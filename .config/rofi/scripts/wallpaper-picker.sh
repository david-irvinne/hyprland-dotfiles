#!/usr/bin/env bash
# ╔══════════════════════════════════════╗
# ║       Rofi Wallpaper Picker          ║
# ║   Supports: GIF, PNG, JPG, WEBP      ║
# ╚══════════════════════════════════════╝

DIR="$HOME/hypr-config/.config/wallpaper/"
CACHE_DIR="$HOME/.cache/wallpaper-picker/thumbs"
RASI="$HOME/.config/rofi/wallpaper-picker.rasi"

# Ukuran thumbnail 16:10
THUMB_W=320
THUMB_H=200

# ── check directory ────────────────────────────────────────────
if [ ! -d "$DIR" ]; then
  notify-send "❌ Wallpaper Error" "Directory not found:\n$DIR" \
    --urgency=critical --app-name="Wallpaper Picker"
  exit 1
fi

mkdir -p "$CACHE_DIR"

# ── Generate thumbnail 16:10 for every format ────────────────
# Cache is saved so it wont always be regenerated  
get_icon() {
  local file="$1"
  local ext="${file,,}"
  local hash
  hash=$(echo "$file" | md5sum | cut -d' ' -f1)
  local thumb="$CACHE_DIR/${hash}.png"

  if [ ! -f "$thumb" ]; then
    if [[ "$ext" == *.gif ]]; then
      # take first frame from GIF then resize to 16:10
      convert "${file}[0]" \
        -thumbnail "${THUMB_W}x${THUMB_H}^" \
        -gravity center \
        -extent "${THUMB_W}x${THUMB_H}" \
        "$thumb" 2>/dev/null
    else
      # PNG, JPG, WEBP — langsung resize ke 16:10
      convert "$file" \
        -thumbnail "${THUMB_W}x${THUMB_H}^" \
        -gravity center \
        -extent "${THUMB_W}x${THUMB_H}" \
        "$thumb" 2>/dev/null
    fi
  fi
  echo "$thumb"
}

# ── collect all wallpaper files ─────────────────────────────
mapfile -t FILES < <(find "$DIR" -type f \( \
  -iname "*.gif" -o \
  -iname "*.png" -o \
  -iname "*.jpg" -o \
  -iname "*.jpeg" -o \
  -iname "*.webp" \
\) | sort)

if [ ${#FILES[@]} -eq 0 ]; then
  notify-send "❌ No Wallpaper Found" "No image files found in:\n$DIR" \
    --urgency=critical --app-name="Wallpaper Picker"
  exit 1
fi

# ── build rofi ──────────────────────────────────────────
ENTRIES=""
for file in "${FILES[@]}"; do
  name=$(basename "$file")
  icon=$(get_icon "$file")
  ENTRIES="${ENTRIES}${name}\0icon\x1f${icon}\n"
done

# ── show rofi ─────────────────────────────────────────────
SELECTED_NAME=$(printf "%b" "$ENTRIES" | rofi \
  -dmenu \
  -i \
  -p "" \
  -theme "$RASI" \
  -show-icons \
  -format s)

[ -z "$SELECTED_NAME" ] && exit 0

# ── find full path for chosen file ──────────────────────────
SELECTED_FILE=""
for file in "${FILES[@]}"; do
  if [ "$(basename "$file")" = "$SELECTED_NAME" ]; then
    SELECTED_FILE="$file"
    break
  fi
done

[ -z "$SELECTED_FILE" ] && exit 1

# ── Terapkan wallpaper via swww ────────────────────────────────
swww img "$SELECTED_FILE" \
  --transition-type random \
  --transition-duration 2 \
  --transition-fps 60 \
  --resize crop

notify-send \
  "🎞️  Wallpaper Applied!" \
  "🖼️ $(basename "$SELECTED_FILE")\n🔁 Transition: random\n📐 Resize: crop" \
  --icon=preferences-desktop-wallpaper \
  --app-name="Wallpaper Picker" \
  --urgency=normal
