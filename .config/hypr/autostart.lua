local programs = require("programs")
hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("waybar & swaync & hypridle &")
	hl.exec_cmd("fcitx5 > /dev/null 2>&1 &")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("swww-daemon &")
	-- hl.exec_cmd("swww img " .. programs.wallpaper .. " --transition-type none --resize crop")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

-- exec-once = nm-applet --indicator
-- exec-once = waybar & swaync & hypridle & # hyprpaper
-- exec-once = fcitx5 > /dev/null 2>&1 &
-- exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
-- exec-once = swww-daemon &
-- exec-once = swww img $wallpaper --transition-type none --resize crop
-- # exec-once = mpvpaper '*' /home/david/hypr-config/.config/wallpaper/watching_sky.mp4 --mpv-options "loop --no-audio video-zoom=0 --panscan=1.0"
-- exec-once = hyprctl setcursor Bibata-Modern-Ice 24
--
-- # screensharing - export environment to systemd for portals
-- exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
-- # Portal services will auto-start on-demand via D-Bus activation
