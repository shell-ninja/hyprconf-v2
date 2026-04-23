#!/bin/bash

# Directories and theme file
scrDir="$HOME/.config/hypr/scripts"
assetsDir="$HOME/.config/hypr/assets"
themeFile="$HOME/.config/hypr/.cache/.theme"

# Retrieve image files (safe globbing, no word-splitting)
shopt -s nullglob nocaseglob
PICS=("${assetsDir}"/*.{jpg,jpeg,png,gif})
shopt -u nullglob nocaseglob

# Strip to basenames
PICS=("${PICS[@]##*/}")

# Exit early if no images found
if [[ ${#PICS[@]} -eq 0 ]]; then
    echo "No images found in ${assetsDir}"
    exit 1
fi

# Rofi command (array avoids word-splitting pitfalls)
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

# No choice case
if [[ -z "$theme" ]]; then
    exit 0
fi

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

echo "$theme" > "$themeFile"

"$scrDir/Wallpaper.sh" &> /dev/null

# hyprland themes
hyprTheme="$HOME/.config/hypr/confs/themes/${theme}.conf"
ln -sf "$hyprTheme" "$HOME/.config/hypr/confs/decoration.conf"

# rofi themes
rofiTheme="$HOME/.config/rofi/colors/${theme}.rasi"
ln -sf "$rofiTheme" "$HOME/.config/rofi/themes/rofi-colors.rasi"

# Kitty themes
kittyTheme="$HOME/.config/kitty/colors/${theme}.conf"
ln -sf "$kittyTheme" "$HOME/.config/kitty/theme.conf"

# Apply new colors dynamically (guard against kitty not running)
if pids=$(pidof kitty 2>/dev/null) && [[ -n "$pids" ]]; then
    kill -SIGUSR1 $pids
fi

# waybar themes
waybarTheme="$HOME/.config/waybar/colors/${theme}.css"
ln -sf "$waybarTheme" "$HOME/.config/waybar/style/theme.css"

# wlogout themes
wlogoutTheme="$HOME/.config/wlogout/colors/${theme}.css"
ln -sf "$wlogoutTheme" "$HOME/.config/wlogout/colors.css"

# set swaync colors
swayncTheme="$HOME/.config/swaync/colors/${theme}.css"
command -v swaync &>/dev/null && ln -sf "$swayncTheme" "$HOME/.config/swaync/colors.css"

# Extract a color value by exact key from kitty conf
extract_color() {
    awk -v key="$1" '$1 == key { print $NF; exit }' "$colors_file"
}


# Setting VS Code / Kvantum theme based on selection
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
    *)
        echo "Warning: Unknown theme selected. No changes applied."
        exit 1
        ;;
esac

# set qt theme
crudini --set "$HOME/.config/Kvantum/kvantum.kvconfig" General theme "${kvTheme}"

# Modify VS Code settings.json
settingsFile="$HOME/.config/Code/User/settings.json"

if [[ ! -f "$settingsFile" ]]; then
    echo "[ ERROR ] VS Code settings file not found at $settingsFile"
else
    sed -i "s|\"workbench.colorTheme\": \".*\"|\"workbench.colorTheme\": \"$vscodeTheme\"|" "$settingsFile"
fi

"$scrDir/Refresh.sh" &> /dev/null
