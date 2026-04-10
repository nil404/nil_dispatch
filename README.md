# nil_dispatch

![FiveM](https://img.shields.io/badge/FiveM-Cerulean-orange)
![Framework](https://img.shields.io/badge/Framework-ESX%20Legacy-blue)
![Lua](https://img.shields.io/badge/Lua-5.4-2C2D72)
![Version](https://img.shields.io/badge/Version-1.0.2-success)

> Modern ESX police dispatch for FiveM with clean NUI, panic workflow, 911 calls, auto shot alerts, vehicle theft detection, and integration-ready API.

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Commands](#commands)
- [Keybinds](#keybinds)
- [Configuration](#configuration)
- [Integration API](#integration-api)
- [Troubleshooting](#troubleshooting)
- [Localization](#localization)

## Features
- Police-only dispatch panel with call cycling and instant waypoint routing.
- Civilian emergency commands: `/911` and `/911a`.
- Police quick actions: `/panic`, `/panicb`, `/ping`.
- Automatic gunshot alerts with token-based anti-abuse checks.
- Automatic suspicious vehicle theft reports.
- Editable panel mode with saved position and size per player.
- Real-time police tracker blips with per-job style overrides.
- Server-side exports and events for external scripts.

## Requirements
- `fx_version 'cerulean'`
- `es_extended` (ESX Legacy shared object)

## Installation
1. Place `nil_dispatch` into your resources directory.
2. Ensure `es_extended` starts before `nil_dispatch`.
3. Add to `server.cfg`:

```cfg
ensure es_extended
ensure nil_dispatch
```

4. Configure jobs, commands, and style in [`config.lua`](./config.lua).

## Commands
| Command | Access | Description |
| --- | --- | --- |
| `/911 [message]` | Everyone | Standard emergency call to police. |
| `/911a [message]` | Everyone | Anonymous emergency call. |
| `/panic [message]` | Police | Panic alert (`10-99`). |
| `/panicb [message]` | Police | Panic B / traffic accident (`10-50`). |
| `/ping [message]` | Police | Broadcast own location (`10-20`). |
| `/dispatchtest [normal\|panic\|anon\|ping\|theft]` | Police | Send test calls for QA. |
| `/dispatchedit [reset]` | Police | Toggle edit mode or reset panel layout. |
| `/dleft` | Police | Fallback: previous call. |
| `/dright` | Police | Fallback: next call. |
| `/dwp` | Police | Fallback: waypoint to selected call. |

## Keybinds
| Action | Default |
| --- | --- |
| Previous call | `LEFT` |
| Next call | `RIGHT` |
| Set waypoint | `G` |

You can change keybind defaults in `config.lua`.

## Configuration
All settings are in [`config.lua`](./config.lua).

### Core Access
- `Config.PoliceJobs` defines allowed dispatch jobs.
- `Config.RequireOnDuty` enforces `job.onduty`.
- `Config.CallCooldownSeconds` limits command spam.
- `Config.AutoExpireMinutes` auto-cleans active calls.

### Auto Alerts
- `Config.ShotAlertEnabled` enables shot fired dispatch creation.
- `Config.ShotAuth*` controls anti-spoof and anti-abuse validation.
- `Config.VehicleTheftAutoEnabled` enables theft auto detection.

### UI and Controls
- `Config.DefaultUiSide` sets panel side (`left` or `right`).
- `Config.KeybindPrevious`, `Config.KeybindNext`, `Config.KeybindWaypoint`.

### Blips and Sounds
- `Config.PriorityBlip*` and `Config.CodeBlip*` customize blip visuals.
- `Config.BlipAreaAlpha` and `Config.AreaBlipRadiusMultiplier` tune area alerts.
- `Config.PlaySoundOnNewCall`, `Config.UseCustomNuiSounds`, and `Config.PlayFrontendFallbackIfNuiFails` configure audio behavior.

## Integration API
Use server-side exports or events to integrate with robbery scripts, MDT, CAD, and custom systems.

### Exports
```lua
-- returns callId or nil, err
local callId, err = exports.nil_dispatch:CreateDispatchCall({
    code = '10-31',
    title = 'Store Robbery',
    message = 'Silent alarm triggered.',
    priority = 3,
    coords = vec3(24.1, -1345.2, 29.4),
    callerName = 'Store Alarm',
    callerSource = 0,
    anonymous = false,
    isArea = false
})

local calls = exports.nil_dispatch:GetActiveDispatchCalls()
local canUse = exports.nil_dispatch:CanUseDispatch(source)
local ok, reason = exports.nil_dispatch:CloseDispatchCall(callId, source)
```

### Events
```lua
TriggerEvent('nil_dispatch:createCall', {
    code = '10-31',
    title = 'Store Robbery',
    message = 'Silent alarm triggered.',
    priority = 3,
    coords = vec3(24.1, -1345.2, 29.4),
    callerName = 'Store Alarm',
    callerSource = 0,
    anonymous = false,
    isArea = false
}, function(callId, err)
    if not callId then
        print(('Dispatch create failed: %s'):format(err or 'unknown'))
    end
end)

TriggerEvent('nil_dispatch:getCalls', function(activeCalls)
    print(('Active calls: %s'):format(#activeCalls))
end)
```

## Troubleshooting
- Dispatch panel not visible for police: check `Config.PoliceJobs`.
- Dispatch panel still missing: if `Config.RequireOnDuty = true`, verify `job.onduty` is true.
- Script loads but no calls: ensure `es_extended` starts before `nil_dispatch`.
- No sound on new call: verify `Config.PlaySoundOnNewCall = true`.
- NUI audio blocked: keep `Config.PlayFrontendFallbackIfNuiFails = true`.
- Shot alerts not firing: verify `Config.ShotAlertEnabled = true` and review `Config.ShotAlertForPolice` behavior.

## Localization
- Some default texts are currently Czech (`Config.Text` + parts of NUI strings).
- Full translation is easy by editing `config.lua` and `html/*` text labels.
