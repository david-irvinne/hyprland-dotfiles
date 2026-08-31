#!/usr/bin/env bash

THEME="$HOME/hypr-config/.config/rofi/exit-hyprland-warning.rasi"

if pgrep -x "rofi" >/dev/null; then
  hyprctl notify 3 2500 "rgb(EF6D6D)" "fontsize:35  Can't launch multiple instances of rofi"
  exit 1
fi

choice=$(
  printf "いいえ\nはい\n" |
    rofi -dmenu -i -theme "$THEME" -p "Exit Hyprland?"
)

case "$choice" in
*"はい"*) command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()' ;;
*) exit 0 ;;
esac
