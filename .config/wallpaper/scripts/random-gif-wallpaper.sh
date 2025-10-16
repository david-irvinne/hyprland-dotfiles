#!/usr/bin/env bash

DIR="$HOME/hypr-config/.config/wallpaper/gifs"
if [ ! -d "$DIR" ]; then
  echo "❌ GIF wallpaper directory not found: $DIR"
  exit 1
fi

FILE=$(find "$DIR" -type f -iname "*.gif" | shuf -n 1)

if [ -z "$FILE" ]; then
  echo "❌ no file GIF found at $DIR"
  exit 1
fi

echo "🎞️  changing wallpaper to gif: $FILE"
swww img "$FILE" --transition-type wipe --resize crop

