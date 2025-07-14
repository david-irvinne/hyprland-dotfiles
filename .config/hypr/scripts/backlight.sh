#!/usr/bin/env bash
#  ┳┓┏┓┏┓┓┏┓┓ ┳┏┓┓┏┏┳┓
#  ┣┫┣┫┃ ┃┫ ┃ ┃┃┓┣┫ ┃ 
#  ┻┛┛┗┗┛┛┗┛┗┛┻┗┛┛┗ ┻ 
#                     


iDIR="$HOME/.config/swaync/icons"
notification_timeout=1000
MIN_BRIGHTNESS=3  # brightness minimum yang diizinkan (%)

# Get brightness
get_backlight() {
	echo $(brightnessctl -m | cut -d, -f4)
}

# Get icons
get_icon() {
	current=$(get_backlight | sed 's/%//')
	if   [ "$current" -le "20" ]; then
		icon="$iDIR/brightness-20.png"
	elif [ "$current" -le "40" ]; then
		icon="$iDIR/brightness-40.png"
	elif [ "$current" -le "60" ]; then
		icon="$iDIR/brightness-60.png"
	elif [ "$current" -le "80" ]; then
		icon="$iDIR/brightness-80.png"
	else
		icon="$iDIR/brightness-100.png"
	fi
}

# Notify
notify_user() {
	notify-send -e -h string:x-canonical-private-synchronous:brightness_notif -h int:value:$current -u low -i "$icon" " Brightness : $current%"
}

# Change brightness
change_backlight() {
  brightnessctl set "$1" && get_icon && notify_user
}

current=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

# Execute accordingly
case "$1" in
	"--get")
		get_backlight
		;;
	"--inc")
		change_backlight "+5%"
		;;
	"--dec")
		if (( current > MIN_BRIGHTNESS )); then
		  change_backlight "5%-"
		fi
		if (( current < MIN_BRIGHTNESS )); then
		  brightnessctl set "${MIN_BRIGHTNESS}%"
		fi	
		;;
	*)
		get_backlight
		;;
esac
