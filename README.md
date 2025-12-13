# Personal Hyprland dotfiles configuration
https://github.com/user-attachments/assets/9a1fc7c2-45cd-4f00-810a-2a0fd4bffee0

## dependencies list
- Window tiling manager: hyprland 
- Top bar: waybar
- App launcher: rofi
- Lockscreen: hyprlock 
- Idle management: hypridle
- Wallpaper: swww (for gif) or hyprpaper (for static)
- Fonts: CaskaydiaCove, Nerd, AwesomeFont
- Notifications: swaync
- Network manager: nm-applet
- Bluetooth manager: blueman-manager
- File search: fd
- Logout menu: wlogout
- Color theme (optional): Catppuccin Mocha
- XDG Desktop Portal: xdg-desktop-portal, xdg-desktop-portal-hyprland, xdg-desktop-portal-gtk

Works on EndeavourOS (Arch Linux based)

## configuration structure
```
hypr-config/
├── .config/
│   ├── hypr/              # Hyprland configuration
│   └── xdg-desktop-portal/ # Portal config for screensharing/screenshot
│       └── portals.conf    # Auto-switching between Hyprland & GNOME portals
└── ...
```

**Note:** `~/.config/xdg-desktop-portal/portals.conf` is a symlink to the file in this repo.

## some screenshots :)
![Swaync](assets/swaync.png)

![Neovim](assets/neovim.png)

![Cmatrix, Btop, and Gurafetch](assets/btop.png)

![Rofi](assets/rofi.png)


