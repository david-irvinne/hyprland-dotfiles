#!/usr/bin/env bash

THEME="$HOME/hypr-config/.config/rofi/power-profile-switcher.rasi"

if pgrep -x "rofi" >/dev/null; then
  hyprctl notify 3 2500 "rgb(EF6D6D)" "fontsize:35  Can't launch multiple instances of rofi"
  exit 1
fi

choice=$(
  printf "󰓅  Performance\n󰾅  Balance\n  Powersave\n" |
    rofi -dmenu -i -theme "$THEME" -p "Power Profile"
)

case "$choice" in
*"Performance"*) profile="performance" ;;
*"Balance"*) profile="reset" ;;
*"Powersave"*) profile="powersave" ;;
*) exit 0 ;;
esac

if command -v pkexec >/dev/null 2>&1; then
  pkexec auto-cpufreq --force "$profile"
else
  sudo auto-cpufreq --force "$profile"
fi

status=$?

case "$profile" in
performance) label="Performance" ;;
powersave) label="Powersave" ;;
reset) label="Balance" ;;
esac

if [ "$status" -eq 0 ]; then
  hyprctl notify 1 2500 "rgb(89B4FA)" "fontsize:30  Power profile: $label"
else
  hyprctl notify 3 2500 "rgb(EF6D6D)" "fontsize:30  Failed to set power profile"
  exit "$status"
fi
