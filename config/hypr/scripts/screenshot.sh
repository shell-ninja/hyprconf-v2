#!/bin/bash

# screenshot.sh — Capture screen or area with Satty annotation

sound_file="/usr/share/sounds/freedesktop/stereo/screen-capture.oga"
save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'hyprland_screenshot_%y%m%d_%H%M%S.png')
temp_screenshot="/tmp/screenshot.png"

mkdir -p "$save_dir"

ss_sound() {
    paplay "$sound_file" 2>/dev/null &
}

option1="Fullscreen"
option2="Selected Area"

options="$option1\n$option2"

choice=$(echo -e "$options" | rofi -dmenu -replace -config ~/.config/rofi/themes/rofi-screenshots.rasi -i -no-show-icons -l 2 -width 30 -p "Screenshot")

case "$choice" in
    "$option1")
        sleep 0.5
        grimblast copysave screen "$temp_screenshot" && ss_sound && \
        satty --filename "$temp_screenshot" --output-filename "$save_dir/$save_file" --early-exit
        ;;
    "$option2")
        grimblast --freeze copysave area "$temp_screenshot" && ss_sound && \
        satty --filename "$temp_screenshot" --output-filename "$save_dir/$save_file" --early-exit
        ;;
esac

# Remove temp file if present
[[ -f "$temp_screenshot" ]] && rm -f "$temp_screenshot"

# Check if final saved file exists
if [ -f "$save_dir/$save_file" ]; then
    notify-send -i "$save_dir/$save_file" "Screenshot saved" "$save_dir/$save_file"
fi
