#!/bin/bash

# Kill already running processes
_ps=(
    dunst
    swaync
    rofi
    waybar
)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" &> /dev/null; then
        pkill "${_prs}"
    fi
done

sleep 0.1
dunst &
swaync &
waybar &

sleep 1
hyprctl reload

exit 0
