const app = document.getElementById('app');
const dragHandle = document.getElementById('dragHandle');
const resizeHandle = document.getElementById('resizeHandle');
const modeBadge = document.getElementById('modeBadge');
const activeCallEl = document.getElementById('activeCall');
const emptyEl = document.getElementById('empty');
const callCodeEl = document.getElementById('callCode');
const callTitleEl = document.getElementById('callTitle');
const callDescEl = document.getElementById('callDesc');
const callMetaEl = document.getElementById('callMeta');
const callAgoEl = document.getElementById('callAgo');
const counterEl = document.getElementById('counter');

const resourceName = typeof GetParentResourceName === 'function'
    ? GetParentResourceName()
    : 'nil_dispatch';

const state = {
    calls: {},
    selectedCallId: null,
    editMode: false,
    drag: {
        active: false,
        offsetX: 0,
        offsetY: 0
    },
    resize: {
        active: false,
        startX: 0,
        startWidth: 0
    }
};

const notificationAudio = new Audio('sound/notification.wav');
notificationAudio.preload = 'auto';
notificationAudio.volume = 0.75;

const panicAudio = new Audio('sound/panic_sound.wav');
panicAudio.preload = 'auto';
panicAudio.volume = 0.9;

const post = async (endpoint, payload = {}) => {
    await fetch(`https://${resourceName}/${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(payload)
    });
};

const notifySoundFailure = (soundName) => {
    post('nuiSoundFailed', { sound: soundName }).catch(() => {});
};

const escapeHtml = (value = '') => {
    return String(value)
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#039;');
};

const sortedCallIds = () => {
    return Object.keys(state.calls)
        .map((id) => Number(id))
        .sort((a, b) => b - a);
};

const timeAgo = (createdAtUnix) => {
    if (!createdAtUnix) {
        return 'pred chvili';
    }

    const now = Math.floor(Date.now() / 1000);
    const diff = Math.max(0, now - Number(createdAtUnix));

    if (diff < 5) {
        return 'prave ted';
    }

    if (diff < 60) {
        return `pred ${diff} s`;
    }

    const minutes = Math.floor(diff / 60);
    if (minutes < 60) {
        return `pred ${minutes} min`;
    }

    const hours = Math.floor(minutes / 60);
    return `pred ${hours} h`;
};

const render = () => {
    const ids = sortedCallIds();
    const panicActive = ids.some((id) => state.calls[id] && state.calls[id].isPanic === true);
    app.classList.toggle('panic-active', panicActive);

    if (ids.length === 0) {
        activeCallEl.classList.add('hidden');
        emptyEl.classList.remove('hidden');
        counterEl.textContent = '0/0';
        return;
    }

    if (!state.selectedCallId || !state.calls[state.selectedCallId]) {
        state.selectedCallId = ids[0];
    }

    const activeId = Number(state.selectedCallId);
    const activeCall = state.calls[activeId];
    if (!activeCall) {
        return;
    }

    const currentIndex = Math.max(0, ids.indexOf(activeId));
    const caller = activeCall.anonymous ? 'Anonymni volajici' : (activeCall.callerName || 'Unknown');

    activeCallEl.classList.remove('hidden');
    emptyEl.classList.add('hidden');
    activeCallEl.classList.toggle('panic', activeCall.isPanic === true);

    callCodeEl.innerHTML = escapeHtml(activeCall.code || 'N/A');
    callTitleEl.innerHTML = escapeHtml(activeCall.title || 'DISPATCH');
    callDescEl.innerHTML = escapeHtml(activeCall.message || '');
    callMetaEl.innerHTML = escapeHtml(caller);
    callAgoEl.innerHTML = timeAgo(activeCall.createdAt);

    counterEl.textContent = `${ids.length - currentIndex}/${ids.length}`;
};

const clamp = (value, min, max) => Math.max(min, Math.min(max, value));
const MIN_WIDTH = 300;
const MAX_WIDTH = 920;

const widthLimit = () => Math.max(MIN_WIDTH, Math.min(MAX_WIDTH, Math.floor(window.innerWidth - 8)));

const applyWidth = (rawWidth) => {
    if (!Number.isFinite(Number(rawWidth))) {
        return;
    }

    const width = clamp(Math.round(Number(rawWidth)), MIN_WIDTH, widthLimit());
    app.style.width = `${width}px`;
};

const applyDragPosition = (x, y) => {
    const maxX = window.innerWidth - app.offsetWidth;
    const maxY = window.innerHeight - app.offsetHeight;

    const clampedX = clamp(x, 0, Math.max(maxX, 0));
    const clampedY = clamp(y, 0, Math.max(maxY, 0));

    app.classList.add('custom-pos');
    app.style.left = `${clampedX}px`;
    app.style.top = `${clampedY}px`;
};

const beginDrag = (event) => {
    if (!state.editMode || state.resize.active || event.button !== 0) {
        return;
    }

    const rect = app.getBoundingClientRect();
    state.drag.active = true;
    state.drag.offsetX = event.clientX - rect.left;
    state.drag.offsetY = event.clientY - rect.top;
};

const dragMove = (event) => {
    if (!state.drag.active || state.resize.active) {
        return;
    }

    applyDragPosition(event.clientX - state.drag.offsetX, event.clientY - state.drag.offsetY);
};

const endDrag = async () => {
    if (!state.drag.active) {
        return;
    }

    state.drag.active = false;
    const rect = app.getBoundingClientRect();
    await post('savePosition', {
        x: Math.round(rect.left),
        y: Math.round(rect.top)
    });
};

const beginResize = (event) => {
    if (!state.editMode || event.button !== 0) {
        return;
    }

    event.preventDefault();
    event.stopPropagation();
    state.resize.active = true;
    state.resize.startX = event.clientX;
    state.resize.startWidth = app.getBoundingClientRect().width;
};

const resizeMove = (event) => {
    if (!state.resize.active) {
        return;
    }

    const nextWidth = state.resize.startWidth + (event.clientX - state.resize.startX);
    applyWidth(nextWidth);

    if (app.classList.contains('custom-pos')) {
        const rect = app.getBoundingClientRect();
        applyDragPosition(rect.left, rect.top);
    }
};

const endResize = async () => {
    if (!state.resize.active) {
        return;
    }

    state.resize.active = false;
    const width = Math.round(app.getBoundingClientRect().width);
    await post('saveSize', { width });
};

const playCustomSound = (soundName) => {
    const audio = soundName === 'panic' ? panicAudio : notificationAudio;

    try {
        audio.pause();
        audio.currentTime = 0;
        const playPromise = audio.play();

        if (playPromise && typeof playPromise.catch === 'function') {
            playPromise.catch(() => {
                notifySoundFailure(soundName);
            });
        } else if (!playPromise) {
            notifySoundFailure(soundName);
        }
    } catch (error) {
        notifySoundFailure(soundName);
    }
};

window.addEventListener('message', (event) => {
    const payload = event.data || {};

    if (payload.action === 'setVisible') {
        app.classList.toggle('hidden', !payload.visible);
        return;
    }

    if (payload.action === 'setLayout') {
        const side = payload.side === 'left' ? 'left' : 'right';
        app.classList.remove('side-left', 'side-right');
        app.classList.add(side === 'left' ? 'side-left' : 'side-right');

        if (payload.hasCustomWidth && Number.isFinite(Number(payload.width))) {
            applyWidth(Number(payload.width));
        } else {
            app.style.width = '';
        }

        if (payload.hasCustomPosition && Number.isFinite(Number(payload.x)) && Number.isFinite(Number(payload.y))) {
            applyDragPosition(Number(payload.x), Number(payload.y));
        } else {
            app.classList.remove('custom-pos');
            app.style.left = '';
            app.style.top = '';
        }
        return;
    }

    if (payload.action === 'setEditMode') {
        state.editMode = payload.enabled === true;
        app.classList.toggle('edit-mode', state.editMode);
        modeBadge.classList.toggle('hidden', !state.editMode);
        return;
    }

    if (payload.action === 'syncCalls') {
        state.calls = payload.calls || {};
        state.selectedCallId = payload.selectedCallId || null;
        render();
        return;
    }

    if (payload.action === 'panicFlash') {
        app.classList.add('panic-flash');
        setTimeout(() => app.classList.remove('panic-flash'), 1200);
        return;
    }

    if (payload.action === 'playSound') {
        playCustomSound(payload.sound);
    }
});

dragHandle.addEventListener('mousedown', beginDrag);
resizeHandle.addEventListener('mousedown', beginResize);
window.addEventListener('mousemove', (event) => {
    dragMove(event);
    resizeMove(event);
});
window.addEventListener('mouseup', () => {
    endDrag();
    endResize();
});

document.addEventListener('keyup', (event) => {
    if (event.key === 'Escape' && state.editMode) {
        post('closeEdit');
    }
});

setInterval(() => {
    if (!app.classList.contains('hidden')) {
        render();
    }
}, 5000);

