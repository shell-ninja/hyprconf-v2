#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_layouts="$HOME/.config/waybar/configs"
waybar_config="$HOME/.config/waybar/config"
waybar_styles="$HOME/.config/waybar/style"
waybar_style="$HOME/.config/waybar/style.css"
script_dir="$HOME/.config/hypr/scripts"
rofi_config="$HOME/.config/rofi/themes/rofi-waybar.rasi"
rofi_menu="$HOME/.config/rofi/menu/menu.rasi"
rofi_clipboard="$HOME/.config/rofi/themes/rofi-clipboard.rasi"
env="$HOME/.config/hypr/confs/env.conf"

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

    if [[ "$1" == "full-top" || "$1" == "rounded-top" ]]; then
        echo "Enabling blur in $env"
        sed -i "/^#blurls = waybar$/ s/#//" "$env"
        sed -i "/^#blurls = waybar$/d" "$env"
    else
        echo "Disabling blur in $env"
        sed -i "/^blurls = waybar$/ s/^/#/" "$env"
    fi

    if [[ "$1" == *"-top"* && ! "$1" == "dual-tone-top" && ! "$1" == "rounded-top" ]]; then
        sed -i "s/location:.*/location: northWest;/g" "$rofi_menu"
        sed -i "s/x-offset:.*/x-offset: 15px;/g" "$rofi_menu"
        sed -i "s/y-offset:.*/y-offset: 15px;/g" "$rofi_menu"

        sed -i "s/location:.*/location: northEast;/g" "$rofi_clipboard"
        sed -i "s/anchor:.*/anchor: northeast;/g" "$rofi_clipboard"
        sed -i "s/y-offset:.*/y-offset: 15px;/g" "$rofi_clipboard"
        sed -i "s/x-offset:.*/x-offset: -15px;/g" "$rofi_clipboard"

    elif [[ "$1" == *"dual-tone-top"* || "$1" == *"rounded-top"* ]]; then
        sed -i "s/location:.*/location: northWest;/g" "$rofi_menu"
        sed -i "s/x-offset:.*/x-offset: 15px;/g" "$rofi_menu"
        sed -i "s/y-offset:.*/y-offset: 15px;/g" "$rofi_menu"

        sed -i "s/location:.*/location: northWest;/g" "$rofi_clipboard"
        sed -i "s/anchor:.*/anchor: northWest;/g" "$rofi_clipboard"
        sed -i "s/y-offset:.*/y-offset: 15px;/g" "$rofi_clipboard"
        sed -i "s/x-offset:.*/x-offset: 15px;/g" "$rofi_clipboard"

    elif [[ "$1" == *"-bottom"* ]]; then
        sed -i "s/location:.*/location: southWest;/g" "$rofi_menu"
        sed -i "s/x-offset:.*/x-offset: 15px;/g" "$rofi_menu"
        sed -i "s/y-offset:.*/y-offset: -15px;/g" "$rofi_menu"

        sed -i "s/location:.*/location: southeast;/g" "$rofi_clipboard"
        sed -i "s/anchor:.*/anchor: southeast;/g" "$rofi_clipboard"
        sed -i "s/x-offset:.*/x-offset: -15px;/g" "$rofi_clipboard"
        sed -i "s/y-offset:.*/y-offset: -15px;/g" "$rofi_clipboard"

    elif [[ "$1" == *"-left"* ]]; then
        sed -i "s/location:.*/location: northWest;/g" "$rofi_menu"
        sed -i "s/x-offset:.*/x-offset: 15px;/g" "$rofi_menu"
        sed -i "s/y-offset:.*/y-offset: 20px;/g" "$rofi_menu"

        sed -i "s/location:.*/location: center;/g" "$rofi_clipboard"
        sed -i "s/anchor:.*/anchor: center;/g" "$rofi_clipboard"
    fi

    restart_waybar
}

# Restart Waybar
restart_waybar() {
    killall waybar
    sleep 0.1  # Delay for Waybar to completely terminate
    waybar &
    sleep 0.5
    hyprctl reload
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
