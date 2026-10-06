#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_layouts="$HOME/.config/waybar/configs"
waybar_config="$HOME/.config/waybar/config"
waybar_styles="$HOME/.config/waybar/style"
waybar_style="$HOME/.config/waybar/style.css"
script_dir="$HOME/.config/hypr/scripts"
window_rules="$HOME/.config/hypr/confs/windowrules.lua"
rofi_config="$HOME/.config/rofi/themes/rofi-waybar.rasi"
rofi_menu="$HOME/.config/rofi/menu/menu.rasi"
rofi_clipboard="$HOME/.config/rofi/themes/rofi-clipboard.rasi"

# Function to display menu options
menu() {
    options=()
    while IFS= read -r file; do
        options+=("$(basename "$file")")
    done < <(find "$waybar_layouts" -maxdepth 1 -type f -exec basename {} \; | sort)

    printf '%s\n' "${options[@]}"
}

# Apply selected configuration
apply_config() {
    layout_file="$waybar_layouts/$1"
    style_file="$waybar_styles/$1.css"

    ln -sf "$layout_file" "$waybar_config"
    ln -sf "$style_file" "$waybar_style"

    # Window rule (blur) for Waybar in Lua
    if [[ -f "$window_rules" ]]; then
        if [[ "$1" == "full-top" || "$1" == "rounded-top" ]]; then
            sed -i '/match = { namespace = "waybar" }/ s/blur = false/blur = true/' "$window_rules"
        else
            sed -i '/match = { namespace = "waybar" }/ s/blur = true/blur = false/' "$window_rules"
        fi
    fi

    # Adjust Rofi menu position
    if [[ "$1" == *"-top"* && ! "$1" == "dual-tone-top" && ! "$1" == "rounded-top" && ! "$1" == "border-top" ]]; then
        [[ -f "$rofi_menu" ]] && sed -i "s/location:.*/location: northWest;/g" "$rofi_menu"
    fi

    # Adjust clipboard rofi position based on selected waybar layout
    if [[ -f "$rofi_clipboard" ]]; then
        case "$1" in
            "minimal-bottom")
                sed -i 's/location:.*/location: southEast;/' "$rofi_clipboard"
                sed -i 's/anchor:.*/anchor: southeast;/' "$rofi_clipboard"
                sed -i 's/x-offset:.*/x-offset: -15px;/' "$rofi_clipboard"
                sed -i 's/y-offset:.*/y-offset: -60px;/' "$rofi_clipboard"
                ;;
            "rounded-top"|"dual-tone-top")
                sed -i 's/location:.*/location: northWest;/' "$rofi_clipboard"
                sed -i 's/anchor:.*/anchor: northwest;/' "$rofi_clipboard"
                sed -i 's/x-offset:.*/x-offset: 15px;/' "$rofi_clipboard"
                sed -i 's/y-offset:.*/y-offset: 40px;/' "$rofi_clipboard"
                ;;
            "bar-left"|"skew-left")
                sed -i 's/location:.*/location: northWest;/' "$rofi_clipboard"
                sed -i 's/anchor:.*/anchor: northwest;/' "$rofi_clipboard"
                sed -i 's/x-offset:.*/x-offset: 50px;/' "$rofi_clipboard"
                sed -i 's/y-offset:.*/y-offset: 15px;/' "$rofi_clipboard"
                ;;
            *)
                sed -i 's/location:.*/location: northEast;/' "$rofi_clipboard"
                sed -i 's/anchor:.*/anchor: northeast;/' "$rofi_clipboard"
                sed -i 's/x-offset:.*/x-offset: -15px;/' "$rofi_clipboard"
                sed -i 's/y-offset:.*/y-offset: 40px;/' "$rofi_clipboard"
                ;;
        esac
    fi

    restart_waybar
}

# Restart Waybar
restart_waybar() {
    killall waybar 2>/dev/null || true
    sleep 0.1
    waybar &
}

# Main function
main() {
    choice=$(menu | rofi -dmenu -config "$rofi_config")

    if [[ -z "$choice" ]]; then
        echo "No option selected. Exiting."
        exit 0
    fi

    apply_config "$choice"
}

if pgrep -x "rofi" &> /dev/null; then
    pkill rofi
    exit 0
fi

main

sleep 0.5
hyprctl reload &>/dev/null || true
