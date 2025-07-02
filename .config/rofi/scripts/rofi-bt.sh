#!/bin/bash

get_powered() {
    bluetoothctl show | grep -q "Powered: yes"
}

toggle_power() {
    if get_powered; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

manage_devices() {
    while true; do
        bluetoothctl scan on & sleep 2 && bluetoothctl scan off

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

            info=$(bluetoothctl info "$mac")
            if echo "$info" | grep -q "Connected: yes"; then
                name="$name [CONNECTED]"
            fi

            if [[ -n "$name" ]]; then
                device_map["$name"]="$mac"
                name_list+=("$name")
            fi
        done

        selection=$(printf "%s\n" "${name_list[@]}" | rofi -dmenu -p "Bluetooth Devices")

        [[ -z "$selection" ]] && exit

        if [[ "$selection" == "🔄 Refresh List" ]]; then
            continue
        fi

        mac="${device_map[$selection]}"

        action=$(echo -e "Connect\nDisconnect\nPair\nRemove" | rofi -dmenu -p "$selection")

        case "$action" in
            "Connect") bluetoothctl connect "$mac" ;;
            "Disconnect") bluetoothctl disconnect "$mac" ;;
            "Pair") bluetoothctl pair "$mac" ;;
            "Remove") bluetoothctl remove "$mac" ;;
        esac

        break
    done
}

# main menu
if get_powered; then
    toggle_label="Turn off Bluetooth"
else
    toggle_label="Turn on Bluetooth"
fi

option=$(printf "%s\n%s" "$toggle_label" "Manage Devices" | rofi -dmenu -p "Bluetooth")

case "$option" in
    "$toggle_label") toggle_power ;;
    "Manage Devices") manage_devices ;;
    *) exit ;;
esac
