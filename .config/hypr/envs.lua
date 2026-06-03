hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--  make qt-based uses wayland
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

-- hyprshot location
hl.env("HYPRSHOT_DIR", "/home/david/Pictures/Screenshots/")

-- Allow better support for screen sharing
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- env = XCURSOR_SIZE,24
-- env = HYPRCURSOR_SIZE,24
--
-- # make qt-based uses wayland
-- env = QT_QPA_PLATFORM,wayland
--
-- xwayland {
--   force_zero_scaling = true
-- }
--
-- # Set hyprshot directory
-- env = HYPRSHOT_DIR, /home/david/Pictures/Screenshots/
--
-- # Allow better support for screen sharing
-- env = XDG_CURRENT_DESKTOP,Hyprland
-- env = XDG_SESSION_DESKTOP,Hyprland
