-- DMS user keybind overrides (edit via Control Center or dms; do not remove this header)

hl.unbind("SUPER + A")
hl.bind("SUPER + A", hl.dsp.exec_cmd("dms ipc call spotlight toggle"), { description = "App launcher" })
hl.unbind("SUPER + M")
hl.bind("SUPER + M", hl.dsp.layout("colresize +conf"), { description = "Cycle column width (scrolling layout)" })
hl.unbind("SUPER + E")
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"), { description = "File manager" })
hl.unbind("SUPER + Q")
hl.bind("SUPER + Q", hl.dsp.exec_cmd("alacritty"), { description = "alacritty" })
hl.unbind("SUPER + C")
hl.bind("SUPER + C", hl.dsp.window.close(), { description = "Close window" })
hl.unbind("SUPER + SHIFT + T")
hl.unbind("SUPER + T")
hl.unbind("SUPER + V")
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }), { description = "Float/unfloat window" })
hl.unbind("SUPER + space")
hl.unbind("SUPER + F")
hl.bind("SUPER + F", hl.dsp.exec_cmd("$HOME/hypr-config/.config/rofi/scripts/rofi-file-search.sh"), { description = "Rofi File Search" })

-- Nonaktifkan gesture horizontal 3 jari bawaan DMS.
-- Gesture vertical 3 jari di hyprland.lua tetap aktif.
hl.gesture({ fingers = 3, direction = "horizontal", action = "unset" })
