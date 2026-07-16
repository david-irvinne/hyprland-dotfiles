#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/hypr"

# if ! hyprctl monitors | grep -q "HDMI-A-1"; then
#   notify-send "Monitor Switch: HDMI-A-1 not connected"
#   exit 1
# fi

case "$1" in
right)
  cp "$CONFIG_DIR/monitor-extend-right.lua" \
    "$CONFIG_DIR/monitors.lua"
  ;;
left)
  cp "$CONFIG_DIR/monitor-extend-left.lua" \
    "$CONFIG_DIR/monitors.lua"
  ;;
top)
  cp "$CONFIG_DIR/monitor-extend-top.lua" \
    "$CONFIG_DIR/monitors.lua"
  ;;
mirror)
  cp "$CONFIG_DIR/monitor-mirror.lua" \
    "$CONFIG_DIR/monitors.lua"
  ;;
*)
  notify-send "Monitor Switch Usage: {right|left|top|mirror}"
  exit 1
  ;;
esac

hyprctl reload
