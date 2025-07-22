#!/bin/bash

CACHE_FILE="/tmp/.wifi_cache"
CACHE_TIMESTAMP="/tmp/.wifi_cache_timestamp"
CACHE_DURATION=60  # detik

refresh_wifi_list() {
  nmcli device wifi rescan
  sleep 2
  nmcli -t -f SSID,SIGNAL device wifi list \
    | awk -F: 'NF && $1 != "" {print $1 ":" $2}' \
    | sort -t: -k2 -nr \
    | awk -F: '!seen[$1]++ {printf "%s (%s%%)\n", $1, $2}' > "$CACHE_FILE"
  date +%s > "$CACHE_TIMESTAMP"
}

if nmcli radio wifi | grep -q enabled; then
  OPTIONS="󰤭  Disable WiFi\n🔄  Refresh WiFi List\n"
else
  OPTIONS="  Enable WiFi\n🔄  Refresh WiFi List\n"
fi

SSID=$(echo -e "$OPTIONS$(cat "$CACHE_FILE")" | rofi -dmenu -normal-window -p "WiFi")

# Handle opsi khusus
case "$SSID" in
  "󰤭  Disable WiFi")
    nmcli radio wifi off
    exit 0
    ;;
  "  Enable WiFi")
    nmcli radio wifi on
    refresh_wifi_list
    exit 0
    ;;
  "🔄  Refresh WiFi List")
    refresh_wifi_list
    "$0" &
    exit 0
    ;;
esac

# Jika SSID dipilih
SSID=$(echo "$SSID" | sed -E 's/ \(.*//')  # hapus (%)
if [ -n "$SSID" ]; then
  if nmcli connection show | grep -q "$SSID" --ask; then
    nmcli connection up "$SSID" --ask
  else
    PASS=$(rofi -dmenu -password -p "Password for $SSID")
    nmcli device wifi connect "$SSID" password "$PASS"
  fi
fi