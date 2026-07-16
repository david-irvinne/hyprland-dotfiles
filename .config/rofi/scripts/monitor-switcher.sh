#!/usr/bin/env bash

SCRIPT="$HOME/hypr-config/.config/hypr/scripts/switch-monitors.sh"
THEME="$HOME/hypr-config/.config/rofi/monitor-switcher.rasi"

choice=$(
  printf "Extend Right\nExtend Left\nExtend Top\nScreen Mirror\n" |
    rofi -dmenu -i -theme "$THEME" -p "Monitor Layout"
)

case "$choice" in
"Extend Right")
  "$SCRIPT" right
  ;;
"Extend Left")
  "$SCRIPT" left
  ;;
"Extend Top")
  "$SCRIPT" top
  ;;
"Screen Mirror")
  "$SCRIPT" mirror
  ;;
*)
  exit 0
  ;;
esac
