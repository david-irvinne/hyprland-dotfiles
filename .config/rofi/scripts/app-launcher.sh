#!/bin/bash

# Check if rofi is already running
if pgrep -x "rofi" > /dev/null; then
    hyprctl notify 3 2500 "rgb(EF6D6D)" "fontsize:35  Can't launch multiple instances of rofi"

    # echo "<NOTICE> $(date +"%Y-%m-%d %H:%M:%S"): Can't launch multiple instances of rofi - Application Launcher" >> ~/script/rofi/application_launcher.log

    exit 1
fi

# Run the rofi command
rofi \
    -show drun \
    -modi drun \
    -drun-match-fields all \
    -drun-display-format "{name}" \
    -no-drun-show-actions \
    -terminal kitty \
    -kb-cancel Escape \
    -theme ~/hypr-config/.config/rofi/application-launcher.rasi

# echo "<NOTICE> $(date +"%Y-%m-%d %H:%M:%S"): Rofi ran successfully - Application Launcher" >> ~/script/rofi/application_launcher.log

# Check the exit status of the rofi command
# if [ $? -ne 0 ]; then
#     hyprctl notify 3 2500 "rgb(EF6D6D)" "fontsize:35   Error: rofi did not run correctly"
#     echo "<NOTICE> $(date +"%Y-%m-%d %H:%M:%S"): Rofi did not run correctly - Application Launcher" >> ~/script/rofi/application_launcher.log
#     exit 1
# fi