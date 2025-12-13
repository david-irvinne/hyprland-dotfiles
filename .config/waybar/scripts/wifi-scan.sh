#!/bin/bash

# WiFi Scan and Notify Script
# Usage: ./wifi-scan.sh

# Check if running as root (some systems need it for scan)
if [[ $EUID -eq 0 ]]; then
   echo "Don't run this script as root"
   exit 1
fi

# Function to send notification
send_notification() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"  # low, normal, critical
    
    notify-send -u "$urgency" "$title" "$message"
}

# Get the WiFi interface name
INTERFACE=$(nmcli -t -f DEVICE,TYPE device | grep wifi | cut -d: -f1 | head -n1)

if [ -z "$INTERFACE" ]; then
    send_notification "WiFi Error" "No WiFi interface found" "critical"
    exit 1
fi

# Send scanning notification
send_notification "WiFi Scan" "Scanning for networks..." "low"

# Trigger WiFi scan
nmcli device wifi rescan 2>/dev/null

# Wait a moment for scan to complete
sleep 2

# Get WiFi list
WIFI_LIST=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | grep -v "^--" | grep -v "^$")

if [ -z "$WIFI_LIST" ]; then
    send_notification "WiFi Scan" "No networks found" "normal"
    exit 0
fi

# Count networks
NETWORK_COUNT=$(echo "$WIFI_LIST" | wc -l)

# Get top 5 networks by signal strength
TOP_NETWORKS=$(echo "$WIFI_LIST" | sort -t: -k2 -nr | head -n5)

# Format the output
OUTPUT=""
while IFS=: read -r SSID SIGNAL SECURITY; do
    # Skip empty SSID
    if [ -z "$SSID" ]; then
        continue
    fi
    
    # Add signal strength bars
    if [ "$SIGNAL" -ge 80 ]; then
        BARS="▂▄▆█"
    elif [ "$SIGNAL" -ge 60 ]; then
        BARS="▂▄▆_"
    elif [ "$SIGNAL" -ge 40 ]; then
        BARS="▂▄__"
    elif [ "$SIGNAL" -ge 20 ]; then
        BARS="▂___"
    else
        BARS="____"
    fi
    
    # Add security icon
    if [[ "$SECURITY" == *"WPA"* ]]; then
        LOCK="🔒"
    else
        LOCK="🔓"
    fi
    
    OUTPUT="${OUTPUT}${LOCK} ${SSID} ${BARS} ${SIGNAL}%\n"
done <<< "$TOP_NETWORKS"

# Send notification with results
send_notification "WiFi Networks Found" "${OUTPUT}Total: ${NETWORK_COUNT} networks" "normal"

# Optional: Save to file
# echo -e "$OUTPUT" > /tmp/wifi-scan-result.txt

echo "Scan complete! Found $NETWORK_COUNT networks."