#!/bin/bash

# secure_mode — applies a neutral/nature wallpaper immediately.

if ! command -v awww &>/dev/null && ! command -v swww &>/dev/null; then
    notify-send "Wallpaper daemon (awww / swww) not found."
    exit 1
fi

ENGINE="awww"
command -v awww &>/dev/null || ENGINE="swww"

scripts_dir="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"

# Find a fallback neutral wallpaper in current themes
Wallpaper=$(find "$HOME/.config/hypr/Wallpapers" -type f \( -name "*.jpg" -o -name "*.png" \) 2>/dev/null | head -n 1)

# Transition config
FPS=60
TYPE="left"
DURATION=0.5
BEZIER=".28,.58,.99,.37"
PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

if ! pgrep -x "${ENGINE}-daemon" >/dev/null; then
    ${ENGINE}-daemon &>/dev/null &
    disown
    sleep 0.3
fi

if [[ -n "$Wallpaper" && -f "$Wallpaper" ]]; then
    ${ENGINE} img "${Wallpaper}" $PARAMS
    mkdir -p "$cache_dir"
    ln -sf "$Wallpaper" "$cache_dir/current_wallpaper.png"
fi

sleep 0.3
"$scripts_dir/wallcache.sh" &>/dev/null &
notify-send "Secure Mode" "Applied safe wallpaper."
