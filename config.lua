Config = {}

-- =========================================================
-- CORE
-- =========================================================
Config.Debug = true
Config.RequireOnDuty = false

Config.PoliceJobs = {
    police = true,
    sheriff = true
}

-- =========================================================
-- COMMANDS / UI
-- =========================================================
Config.Command911 = '911'
Config.Command911Anonymous = '911a'
Config.CommandPanic = 'panic'
Config.CommandPanicB = 'panicb' -- 10-50
Config.CommandPing = 'ping'
Config.CommandDispatchTest = 'dispatchtest'
Config.CommandDispatchEdit = 'dispatchedit'

--fallback for ui
Config.CommandDispatchPrev = 'dleft'
Config.CommandDispatchNext = 'dright'
Config.CommandDispatchWaypoint = 'dwp'
-- end of it

Config.DefaultUiSide = 'right'
Config.MaxVisibleCalls = 6
Config.KeybindPrevious = 'LEFT'
Config.KeybindNext = 'RIGHT'
Config.KeybindWaypoint = 'G'

-- =========================================================
-- CALL LIMITS / LIFETIME
-- =========================================================
Config.CallCooldownSeconds = 10
Config.MaxMessageLength = 220
Config.AutoExpireMinutes = 5

-- =========================================================
-- DISPATCH CODES
-- =========================================================
Config.DefaultCodes = {
    emergency = '911',
    emergency_anonymous = '911A',
    panic = '10-99',
    panicb = '10-50',
    vehicle_theft = '10-16',
    ping = '10-20',
    officer = '10-13',
    dispatch = '10-20'
}

Config.PriorityNames = {
    [1] = 'LOW',
    [2] = 'MEDIUM',
    [3] = 'HIGH'
}

-- =========================================================
-- SHOT ALERT
-- =========================================================
Config.ShotAlertEnabled = true
Config.ShotAlertForPolice = true
Config.ShotAlertAllowCivilians = true
Config.ShotAlertOnlyUnsilenced = false
Config.ShotAlertCooldownSeconds = 8
Config.ShotAlertAreaRadius = 120.0
Config.ShotAlertCode = '10-13'
Config.ShotAlertTitle = 'NEKDO STRILI'
Config.ShotAlertPriority = 2

-- random center in circle (shooter is in area, not on main blip)
Config.ShotAlertUseRandomizedCenter = true
Config.ShotAlertCenterMinOffset = 28.0
Config.ShotAlertCenterMaxOffset = 90.0

-- =========================================================
-- VEHICLE THEFT ALERT
-- =========================================================
Config.VehicleTheftAutoEnabled = true
Config.VehicleTheftAlertForPolice = true
Config.VehicleTheftCooldownSeconds = 90
Config.VehicleTheftMaxCoordDistance = 90.0
Config.VehicleTheftCode = '10-16'
Config.VehicleTheftTitle = 'KRADEZ VOZIDLA'
Config.VehicleTheftPriority = 2
Config.VehicleTheftReportAnyDriverEntry = false

-- =========================================================
-- SHOT AUTH / ABUSE PROTECTION
-- =========================================================
Config.ShotAuthEnabled = true
Config.ShotAuthTokenTtlSeconds = 15
Config.ShotAuthRequestCooldownMs = 1000
Config.ShotAuthMinEventIntervalMs = 750
Config.ShotAuthMaxCoordDistance = 45.0
Config.ShotAuthInvalidLimit = 6
Config.ShotAuthInvalidWindowSeconds = 30
Config.ShotAuthDropOnAbuse = false

-- =========================================================
-- GLOBAL BLIP / SOUND
-- =========================================================
Config.BlipDurationSeconds = 180
Config.BlipScale = 1.0
Config.BlipAreaAlpha = 90
Config.AreaBlipRadiusMultiplier = 0.65
Config.BlipRouteColor = 3

Config.PlaySoundOnNewCall = true
Config.UseCustomNuiSounds = true
Config.PlayFrontendFallbackIfNuiFails = true
Config.SoundName = 'ATM_WINDOW'
Config.SoundSet = 'HUD_FRONTEND_DEFAULT_SOUNDSET'

-- =========================================================
-- DEFAULT BLIP STYLE (fallback when no theme is active)
-- =========================================================
Config.PriorityBlipSprites = {
    [1] = 57,
    [2] = 41,
    [3] = 42
}

Config.PriorityBlipColors = {
    [1] = 38,
    [2] = 3,
    [3] = 1
}

Config.PriorityBlipScale = {
    [1] = 0.92,
    [2] = 1.0,
    [3] = 1.14
}

Config.PriorityBlipFlash = {
    [1] = false,
    [2] = true,
    [3] = true
}

Config.PriorityBlipFlashIntervalMs = {
    [1] = 0,
    [2] = 650,
    [3] = 280
}

Config.CodeBlipSprites = {
    ['10-20'] = 480,
    ['10-50'] = 641,
    ['10-16'] = 488,
    ['10-66'] = 161,
    ['10-71'] = 42,
    ['10-99'] = 458,
    ['10-13'] = 313,
    ['911'] = 41,
    ['911A'] = 41
}

Config.CodeBlipColors = {
    ['10-20'] = 38,
    ['10-50'] = 48,
    ['10-16'] = 69,
    ['10-66'] = 46,
    ['10-71'] = 1,
    ['10-99'] = 1,
    ['10-13'] = 38,
    ['911'] = 1,
    ['911A'] = 2
}

Config.CodeBlipScale = {
    ['10-20'] = 0.9,
    ['10-50'] = 1.02,
    ['10-16'] = 1.02,
    ['10-66'] = 1.02,
    ['10-71'] = 1.08,
    ['10-99'] = 1.2,
    ['10-13'] = 1.24,
    ['911'] = 1.04,
    ['911A'] = 1.04
}

Config.CodeBlipFlash = {
    ['10-20'] = false,
    ['10-50'] = true,
    ['10-16'] = true,
    ['10-66'] = true,
    ['10-71'] = true,
    ['10-99'] = true,
    ['10-13'] = true,
    ['911'] = true,
    ['911A'] = true
}

Config.CodeBlipFlashIntervalMs = {
    ['10-50'] = 420,
    ['10-16'] = 380,
    ['10-66'] = 360,
    ['10-71'] = 340,
    ['10-99'] = 220,
    ['10-13'] = 170,
    ['911'] = 360,
    ['911A'] = 420
}

Config.PriorityAreaBlipColors = {
    [1] = 3,
    [2] = 3,
    [3] = 3
}

Config.CodeAreaBlipColors = {
    ['10-13'] = 3
}

Config.CodeAreaBlipAlpha = {
    ['10-13'] = 54
}

-- =========================================================
-- POLICE TRACKER (PD BLIPS)
-- =========================================================
Config.PoliceTrackerEnabled = true
Config.PoliceTrackerUpdateMs = 1200
Config.PoliceTrackerSprite = 60
Config.PoliceTrackerColor = 38
Config.PoliceTrackerScale = 0.8
Config.PoliceTrackerShowHeading = false
Config.PoliceTrackerShowSelf = true

Config.PoliceTrackerJobBlips = {
    police = {
        sprite = 60,
        color = 29,
        scale = 0.85
    },
    sheriff = {
        sprite = 58,
        color = 17,
        scale = 0.85
    }
}

Config.PoliceTrackerJobLabels = {
    police = 'LSPD',
    sheriff = 'Sheriff'
}

-- =========================================================
-- TEXTS
-- =========================================================
Config.Text = {
    only_police = 'Tento prikaz je pouze pro policii.',
    only_on_duty = 'Musis byt ve sluzbe.',
    call_sent = 'Dispatch hovor byl odeslan.',
    call_accepted = 'Hovor prijat, trasa nastavena.',
    call_closed = 'Hovor byl uzavren.',
    call_not_found = 'Hovor nebyl nalezen.',
    call_already_taken = 'Hovor uz ma pridelenou jednotku.',
    call_invalid_message = 'Napis zpravu delsi nez 3 znaky.',
    call_cooldown = 'Pockej %s sekund pred dalsim hovorem.',
    no_permission_close = 'Nemuzes uzavrit cizi hovor.',
    no_active_calls = 'Nemas zadne aktivni hovory.',
    panic_sent = 'Panic signal odeslan vsem jednotkam.',
    panicb_sent = 'Panic B (nehoda) signal odeslan.',
    vehicle_theft_sent = '10-16 kradez vozidla byla odeslana.',
    ping_sent = 'Tvoje 10-20 lokace byla odeslana kolegum.',
    panic_usage = 'Pouziti: /panic [volitelna zprava]',
    panicb_usage = 'Pouziti: /panicb [volitelna zprava]',
    ping_usage = 'Pouziti: /ping [volitelna zprava]',
    anonymous_emergency_usage = 'Pouziti: /911a [zprava]',
    anonymous_call_sent = 'Anonymni 911 hovor byl predan policii.',
    dispatchtest_usage = 'Pouziti: /dispatchtest [normal|panic|anon|ping|theft]',
    dispatchtest_sent = 'Test dispatch (%s) byl odeslan.',
    menu_opened = 'Dispatch panel je v rezimu ovladani.',
    menu_closed = 'Dispatch panel ovladani vypnuto.',
    side_switched = 'Dispatch panel je ted na strane: %s.',
    emergency_usage = 'Pouziti: /911 [zprava]'
}
