#!/usr/bin/env bash

DIR="$HOME/hypr-config/.config/wallpaper/"
if [ ! -d "$DIR" ]; then
  notify-send "❌ Wallpaper Error" "Directory not found:\n$DIR" --urgency=critical --app-name="SWWW"
  exit 1
fi

FILE=$(find "$DIR" -type f -iname "*.*" | shuf -n 1)

if [ -z "$FILE" ]; then
  notify-send "❌ No GIF Found" "No GIF file located in:\n$DIR" --urgency=critical --app-name="SWWW"
  exit 1
fi

TRANS="random"
RESIZE="crop"

notify-send \
  "🎞️  New Wallpaper Applied!" \
  "🖼️ File: $(basename "$FILE")\n🔁 Transition: $TRANS\n📐 Resize: $RESIZE" \
  --icon=preferences-desktop-wallpaper \
  --app-name="SWWW Wallpaper" \
  --urgency=normal

# Terapkan wallpaper
swww img "$FILE" --transition-type "$TRANS" --resize "$RESIZE"
