fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author '.nil.404'
description 'Police dispatch'
version '1.0.2'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'html/sound/notification.wav',
    'html/sound/panic_sound.wav'
}

