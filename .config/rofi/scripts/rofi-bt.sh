#!/bin/bash

toggle_power() {
    current=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
    if [[ "$current" == "yes" ]]; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

manage_devices() {
    while true; do
        bluetoothctl scan on & sleep 3 && bluetoothctl scan off

        mapfile -t devices < <(bluetoothctl devices)

        if [[ ${#devices[@]} -eq 0 ]]; then
            notify-send "Bluetooth" "No paired devices found."
            exit
        fi

        declare -A device_map
        name_list=("🔄 Refresh List")

        for line in "${devices[@]}"; do
            mac=$(echo "$line" | awk '{print $2}')
            name="${line#* $mac }"

            # Cek apakah device sedang connected
            info=$(bluetoothctl info "$mac")
            if echo "$info" | grep -q "Connected: yes"; then
                name="$name [CONNECTED]"
            fi

            if [[ -n "$name" ]]; then
                device_map["$name"]="$mac"
                name_list+=("$name")
            fi
        done

        selection=$(printf "%s\n" "${name_list[@]}" | rofi -normal-window -dmenu -p "Bluetooth Devices")

        [[ -z "$selection" ]] && exit

        if [[ "$selection" == "🔄 Refresh List" ]]; then
            continue
        fi

        mac="${device_map[$selection]}"

        action=$(echo -e "Connect\nDisconnect\nPair\nRemove" | rofi -normal-window -dmenu -p "$selection")

        case "$action" in
            "Connect") bluetoothctl connect "$mac" ;;
            "Disconnect") bluetoothctl disconnect "$mac" ;;
            "Pair") bluetoothctl pair "$mac" ;;
            "Remove") bluetoothctl remove "$mac" ;;
        esac

        break
    done
}

# Menu utama
option=$(echo -e "Toggle Power\nManage Devices" | rofi -normal-window -dmenu -p "Bluetooth")

case "$option" in
    "Toggle Power") toggle_power ;;
    "Manage Devices") manage_devices ;;
    *) exit ;;
esac
