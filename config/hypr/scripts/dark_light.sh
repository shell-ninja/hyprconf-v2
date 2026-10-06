#!/bin/bash
# dark_light.sh — Toggle between dark and light appearance modes.

mode_file="$HOME/.config/hypr/.cache/.current_mode"
next_mode_file="$HOME/.config/hypr/.cache/.next_mode"
scripts_dir="$HOME/.config/hypr/scripts"
cache_dir="$HOME/.config/hypr/.cache"

mkdir -p "$cache_dir"

# Initialise mode files if missing
[[ ! -f "$mode_file" ]]      && echo "dark"  > "$mode_file"
[[ ! -f "$next_mode_file" ]] && echo "light" > "$next_mode_file"

next_mode=$(< "$next_mode_file")

if [[ "$next_mode" == "light" ]]; then
    notify-send "Appearance" "Switching to Light Mode" -t 1500

    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    gsettings set org.gnome.desktop.interface gtk-theme "Everforest"

    if [[ -f "$HOME/.config/nvim/lua/shell-ninja/plugins/colorscheme.lua" ]]; then
        sed -i 's/mocha/latte/g' "$HOME/.config/nvim/lua/shell-ninja/plugins/colorscheme.lua"
    fi

    echo "dark"  > "$next_mode_file"
    echo "light" > "$mode_file"

elif [[ "$next_mode" == "dark" ]]; then
    notify-send "Appearance" "Switching to Dark Mode" -t 1500

    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin"

    if [[ -f "$HOME/.config/nvim/lua/shell-ninja/plugins/colorscheme.lua" ]]; then
        sed -i 's/latte/mocha/g' "$HOME/.config/nvim/lua/shell-ninja/plugins/colorscheme.lua"
    fi

    echo "light" > "$next_mode_file"
    echo "dark"  > "$mode_file"
fi

"$scripts_dir/Refresh.sh" &> /dev/null &
