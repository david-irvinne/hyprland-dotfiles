#!/bin/bash

# Cek apakah Bluetooth aktif
powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ $powered == "yes" ]]; then
    # Cek apakah ada device yang terhubung
    connected_device=$(bluetoothctl info | grep "Name:" | head -n1 | awk -F ': ' '{print $2}')
    if [[ -n "$connected_device" ]]; then
        
        echo "{\"text\": \"󰂴 オン\", \"tooltip\": \"$connected_device に接続中\"}"
    else
        echo "{\"text\": \"󰂴 オン\", \"tooltip\": \"接続なし\"}"
    fi
else
    echo "{\"text\": \"󰂲 オフ\"}"
fi
