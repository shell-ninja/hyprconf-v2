#!/bin/bash

# animations_toggle.sh — Toggle animations on/off in Hyprland

animations=$(hyprctl getoption animations:enabled 2>/dev/null | awk '/int:/ {print $2}')
[ -z "$animations" ] && animations=$(hyprctl getoption animations:enabled 2>/dev/null | awk '/custom type:/ {print $3}')
[ -z "$animations" ] && animations=$(hyprctl getoption animations:enabled 2>/dev/null | awk 'NR==1 {print $2}')

animationsConf="$HOME/.config/hypr/confs/animations.lua"
icon="$HOME/.config/hypr/icons/animation.svg"

notify_off() {
    notify-send -i "$icon" "Animations" "Disabled Animations." 2>/dev/null || notify-send "Animations" "Disabled Animations."
}

notify_on() {
    notify-send -i "$icon" "Animations" "Enabled Animations." 2>/dev/null || notify-send "Animations" "Enabled Animations."
}

if [[ "$animations" == "1" || "$animations" == "true" ]]; then
    notify_off
    hyprctl keyword animations:enabled 0
    if [[ -f "$animationsConf" ]]; then
        sed -i 's/\(enabled[[:space:]]*=[[:space:]]*\)[true1]*/\1false/' "$animationsConf"
    fi
else
    notify_on
    hyprctl keyword animations:enabled 1
    if [[ -f "$animationsConf" ]]; then
        sed -i 's/\(enabled[[:space:]]*=[[:space:]]*\)[false0]*/\1true/' "$animationsConf"
    fi
fi
