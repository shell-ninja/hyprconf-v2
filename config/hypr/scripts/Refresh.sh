#!/bin/bash
# Refresh.sh — Restart notification daemon and reload Hyprland.

# Kill running daemons
_ps=(swaync rofi)
for _prs in "${_ps[@]}"; do
    pidof "${_prs}" &>/dev/null && pkill -SIGTERM "${_prs}"
done

sleep 0.4
swaync &

hyprctl reload

exit 0

