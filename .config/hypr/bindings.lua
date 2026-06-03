-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local programs = require("programs")
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local mainModShift = "SUPER + SHIFT"

-- PROGRAMS
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.file_manager))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a -f hex"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(programs.change_wallpaper))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.randomize_wallpaper))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(programs.file_search))
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window"))
-- bind = shift, PRINT, exec,
-- bind = ,PRINT, exec, hyprshot -m region

-- Window operation & manipulation
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(
	mainModShift .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
-- Move window inside workspace
hl.bind(mainModShift .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainModShift .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainModShift .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainModShift .. " + J", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainModShift .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- # Resize active window
-- bindde = SUPER, code:20, Expand window left, resizeactive, -50 0        # -, expand horizontal
-- bindde = SUPER, code:21, Shrink window left, resizeactive, 50 0         # =, shrink horizontal
-- bindde = SUPER SHIFT, code:20, Shrink window up, resizeactive, 0 50     # shift -, shrink vertical
-- bindde = SUPER SHIFT, code:21, Expand window down, resizeactive, 0 -50  # shift =, expand vertical

hl.bind(mainMod .. "+ right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. "+ left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. "+ up", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mainMod .. "+ down", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

-- Cycle window column width: halfscreen & fullscreen (useful in scrolling layout)
hl.bind(mainMod .. " + M", hl.dsp.layout("colresize +conf"))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + page_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + page_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainModShift .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Debugging
hl.bind(mainModShift .. " + W", hl.dsp.exec_cmd("pkill waybar && waybar &"))
hl.bind(mainModShift .. " + Y", hl.dsp.exec_cmd("swaync-client -rs && swaync-client --reload-config"))

-- zoom screen
-- bind = Ctrl+Super, mouse:272, exec, hyprctl keyword cursor:zoom_factor 3.0
-- bindr = Ctrl+Super, mouse:272, exec, hyprctl keyword cursor:zoom_factor 1.0
-- hl.bind("CTRL + SUPER + mouse:272", hl.dsp.cursor.zoo("hyprctl keyword cursor:zoom_factor 3.0"))
-- hl.bind("CTRL + SUPER + mouse:272", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1.0"), { release = true })
hl.bind("CTRL + SUPER + mouse:272", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 3.0"))
hl.bind("CTRL + SUPER + mouse:272", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1.0"), { release = true })

-- TODO: test this
-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
