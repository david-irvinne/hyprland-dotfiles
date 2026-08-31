#!/bin/bash

# Direktori yang ingin dicari (ubah sesuai kebutuhan)
SEARCH_DIR="$HOME"

# Panggil fd untuk mencari file berdasarkan input dari user (dengan rofi)
SELECTED=$(
  fd --type f . "$SEARCH_DIR" --color never |
    sed 's|^'"$SEARCH_DIR"'/||' |
    grep -i "$QUERY" |
    rofi -dmenu -i -p "" \
      -theme ~/hypr-config/.config/rofi/file-search.rasi
)

# Jika user memilih file, buka file tersebut
if [ -n "$SELECTED" ]; then
  TARGET="$SEARCH_DIR/$SELECTED"
  MIME_TYPE=$(file --brief --mime-type "$TARGET")

  if [[ "$MIME_TYPE" == text/* ]]; then
    alacritty -e nvim -- "$TARGET" &
  else
    xdg-open "$TARGET"
  fi
fi
