#!/bin/bash

# Directories and theme file
scrDir="$HOME/.config/hypr/scripts"
assetsDir="$HOME/.config/hypr/assets"
themeFile="$HOME/.config/hypr/.cache/.theme"

# Retrieve image files (safe globbing, no word-splitting)
shopt -s nullglob nocaseglob
PICS=("${assetsDir}"/*.{jpg,jpeg,png,gif})
shopt -u nullglob nocaseglob

# Exit early if no images found
if [[ ${#PICS[@]} -eq 0 ]]; then
    echo "No images found in ${assetsDir}"
    exit 1
fi

# Strip to basenames
PICS=("${PICS[@]##*/}")

# Rofi command
rofi_cmd=(rofi -show -dmenu -config ~/.config/rofi/themes/rofi-theme-select.rasi)

menu() {
    for pic in "${PICS[@]}"; do
        if [[ "${pic,,}" != *.gif ]]; then
            # Display name without extension, with icon preview
            printf '%s\x00icon\x1f%s/%s\n' "${pic%.*}" "${assetsDir}" "${pic}"
        else
            printf '%s\n' "${pic}"
        fi
    done
}

theme=$(menu | "${rofi_cmd[@]}")

# Exit if no theme was selected
[[ -z "$theme" ]] && exit 0

# Find matching image
pic_index=-1
for i in "${!PICS[@]}"; do
    if [[ "${PICS[$i]}" == "${theme}"* ]]; then
        pic_index=$i
        break
    fi
done

if [[ $pic_index -ne -1 ]]; then
    notify-send -i "${assetsDir}/${PICS[$pic_index]}" "Changing to $theme" -t 1500
else
    echo "Image not found."
    exit 1
fi

# Save selected theme
echo "$theme" > "$themeFile"

# Apply Wallpaper
"$scrDir/Wallpaper.sh" &> /dev/null

# Function to safely symlink
safe_link() {
    local source_file="$1"
    local target_link="$2"
    if [[ -f "$source_file" ]]; then
        mkdir -p "$(dirname "$target_link")"
        ln -sf "$source_file" "$target_link"
    fi
}

# Apply UI Themes
safe_link "$HOME/.config/hypr/confs/themes/${theme}.conf" "$HOME/.config/hypr/confs/decoration.conf"
safe_link "$HOME/.config/rofi/colors/${theme}.rasi" "$HOME/.config/rofi/themes/rofi-colors.rasi"
safe_link "$HOME/.config/kitty/colors/${theme}.conf" "$HOME/.config/kitty/theme.conf"
safe_link "$HOME/.config/waybar/colors/${theme}.css" "$HOME/.config/waybar/style/theme.css"
safe_link "$HOME/.config/wlogout/colors/${theme}.css" "$HOME/.config/wlogout/colors.css"

if command -v swaync &>/dev/null; then
    safe_link "$HOME/.config/swaync/colors/${theme}.css" "$HOME/.config/swaync/colors.css"
fi

# Apply new colors dynamically to Kitty
if pids=$(pidof kitty 2>/dev/null) && [[ -n "$pids" ]]; then
    kill -SIGUSR1 $pids
fi

# Setting VS Code / Kvantum theme based on selection
kvTheme=""
vscodeTheme=""

case "$theme" in
    Catppuccin)
        vscodeTheme="Catppuccin Mocha"
        kvTheme="Catppuccin"
        ;;
    Everforest)
        vscodeTheme="Everforest Dark"
        kvTheme="Everforest"
        ;;
    Gruvbox)
        vscodeTheme="Gruvbox Dark Soft"
        kvTheme="Gruvbox"
        ;;
    Neon)
        vscodeTheme="Neon Dark Theme"
        kvTheme="Nordic-Darker"
        ;;
    TokyoNight)
        vscodeTheme="Tokyo Storm Gogh"
        kvTheme="TokyoNight"
        ;;
    X)
        vscodeTheme="X"
        kvTheme="X"
        ;;
    *)
        echo "Warning: Unknown theme '$theme'. Core WM themes applied, but skipping VS Code/Kvantum."
        ;;
esac

# Apply Qt and VS Code themes only if mapped
if [[ -n "$kvTheme" && -n "$vscodeTheme" ]]; then
    crudini --set "$HOME/.config/Kvantum/kvantum.kvconfig" General theme "${kvTheme}"

    settingsFile="$HOME/.config/Code/User/settings.json"
    if [[ ! -f "$settingsFile" ]]; then
        echo "[ ERROR ] VS Code settings file not found at $settingsFile"
    else
        # Stricter regex to prevent messing up other JSON keys on the same line
        sed -i -E 's/("workbench.colorTheme"[ \t]*:[ \t]*)"[^"]+"/\1"'"$vscodeTheme"'"/' "$settingsFile"
    fi
fi

# Refresh the environment
"$scrDir/Refresh.sh" &> /dev/null
