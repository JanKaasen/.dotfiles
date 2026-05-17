-- hyprland.lua
-- Converted from hyprland.conf to Lua (Hyprland 0.55+)
-- Ref: https://wiki.hypr.land/Configuring/Start/

--------------------
---- PROGRAMS ----
--------------------

local terminal    = "ghostty"
local fileManager = "thunar"
local menu        = "hyprlauncher"
local browser     = "zen-browser"

--------------------
---- MONITORS ----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

--------------------
---- AUTOSTART ----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- hl.exec_cmd() is async, no need for & at the end
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprctl setcursor Adwaita 20")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprlauncher -d")  -- start daemon so it opens instantly
end)

-----------------------------
---- ENVIRONMENT VARIABLES ----
-----------------------------

-- Managed by uwsm, not set here.
-- Common vars: ~/.config/uwsm/env
-- Hyprland/NVIDIA vars: ~/.config/uwsm/env-hyprland

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- See https://wiki.hypr.land/Configuring/Variables/

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },

    general = {
        gaps_in       = 5,
        gaps_out      = 20,
        border_size   = 2,
        col = {
            active_border   = { colors = {"rgba(ffdd33ee)", "rgba(73c936ee)"}, angle = 45 },
            inactive_border = "rgba(453d41aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled   = true,
            size      = 6,
            passes    = 8,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        -- pseudotile removed in 0.55 (use hl.dsp.window.pseudo() bind instead)
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    input = {
        kb_layout    = "eu",
        follow_mouse = 1,
        sensitivity  = 0,
        force_no_accel = true,
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Bezier curve (kept for future use when you re-enable animations)
-- See https://wiki.hypr.land/Configuring/Animations/
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

-- Per-device input config
-- See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

--------------------
---- KEYBINDINGS ----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())           -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))     -- dwindle

-- Move focus (hjkl)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down"  }))

-- Switch / move to workspaces 1-10
for i = 1, 10 do
    local key = i % 10  -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces with mainMod + scroll wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse drag
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume keys (repeating = true replaces bindel)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),   { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),   { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true })

-- Brightness keys (repeating)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true })

-- Media keys (locked = true replaces bindl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),         { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),   { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),   { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),     { locked = true })

-- Screenshots
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("hyprshot -m region --freeze output --clipboard-only"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("hyprshot -m region --freeze"))

------------------------------
---- WINDOWS AND WORKSPACES ----
------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Suppress maximize requests from apps
hl.window_rule({
    match           = { class = ".*" },
    suppress_event  = "maximize",
})

-- Fix dragging issues with XWayland
hl.window_rule({
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        fullscreen = false,
    },
    no_focus = true,
})
