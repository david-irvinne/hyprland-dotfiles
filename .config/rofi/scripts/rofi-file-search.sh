#!/bin/bash

# Direktori yang ingin dicari (ubah sesuai kebutuhan)
SEARCH_DIR="$HOME"

# Panggil fd untuk mencari file berdasarkan input dari user (dengan rofi)
SELECTED=$(fd --type f . "$SEARCH_DIR" --color never \
    | sed 's|^'"$SEARCH_DIR"'/||' \
    | grep -i "$QUERY" \
    | rofi -dmenu -i -p "ファイル検索 "  \
    -theme ~/hypr-config/.config/rofi/file-search.rasi
    )

# Jika user memilih file, buka file tersebut
if [ -n "$SELECTED" ]; then
    xdg-open "$SEARCH_DIR/$SELECTED"
fi

