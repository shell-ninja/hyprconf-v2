#!/bin/bash

# Kill already running processes
_ps=(
    dunst
    rofi
    # waybar
)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" &> /dev/null; then
        pkill "${_prs}"
    fi
done

sleep 0.3
# waybar &
hyprctl reload

exit 0
