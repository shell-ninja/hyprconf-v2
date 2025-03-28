#!/bin/bash

# Directories and theme file
scrDir="$HOME/.config/hypr/scripts"
assetsDir="$HOME/.config/hypr/assets"
themeFile="$HOME/.config/hypr/.cache/.theme"

# Retrieve image files
PICS=($(ls "${assetsDir}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))

# Rofi command ( style )
rofi_command2="rofi -show -dmenu -config ~/.config/rofi/themes/rofi-theme-select.rasi"

menu() {
  for i in "${!PICS[@]}"; do
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${assetsDir}/${PICS[$i]}\n"
    else
      printf "${PICS[$i]}\n"
    fi
  done
}

theme=$(menu | ${rofi_command2})

# No choice case
if [[ -z $theme ]]; then
  exit 0
fi

pic_index=-1
for i in "${!PICS[@]}"; do
  filename=$(basename "${PICS[$i]}")
  if [[ "$filename" == "$theme"* ]]; then
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
"$scrDir/Refresh.sh" &> /dev/null

# hyprland themes
hyprTheme="$HOME/.config/hypr/confs/themes/${theme}.conf"
ln -sf "$hyprTheme" "$HOME/.config/hypr/confs/decoration.conf"

# rofi themes
rofiTheme="$HOME/.config/rofi/colors/${theme}.rasi"
ln -sf "$rofiTheme" "$HOME/.config/rofi/themes/rofi-colors.rasi"

# Kitty themes
kittyTheme="$HOME/.config/kitty/colors/${theme}.conf"
ln -sf "$kittyTheme" "$HOME/.config/kitty/theme.conf"

# Apply new colors dynamically
kill -SIGUSR1 $(pidof kitty)

# waybar themes
waybarTheme="$HOME/.config/waybar/colors/${theme}.css"
ln -sf "$waybarTheme" "$HOME/.config/waybar/style/theme.css"


# ----- Dunst
dunst_file="$HOME/.config/dunst/dunstrc"
colors_file="$HOME/.config/kitty/colors/${theme}.conf"

# Function to extract colors from Kitty .conf file
extract_color() {
    grep -E "^$1" "$colors_file" | awk '{print $NF}'
}

# Extract colors
frame=$(extract_color "foreground")
normal_bg=$(extract_color "background")
normal_fg=$(extract_color "foreground")

# Define missing colors (assuming low urgency should match normal)
low_bg="$normal_bg"
low_fg="$normal_fg"


# Function to update Dunst colors
update_dunst_colors() {
    # Update Dunst configuration
    sed -i "s/frame_color = .*/frame_color = \"$frame\"/g" "$dunst_file"
    sed -i "/^\[urgency_low\]/,/^\[/ s/^    background = .*/    background = \"$low_bg\"/g" "$dunst_file"
    sed -i "/^\[urgency_low\]/,/^\[/ s/^    foreground = .*/    foreground = \"$low_fg\"/g" "$dunst_file"
    sed -i "/^\[urgency_normal\]/,/^\[/ s/^    background = .*/    background = \"${normal_bg}80\"/g" "$dunst_file"
    sed -i "/^\[urgency_normal\]/,/^\[/ s/^    foreground = .*/    foreground = \"$normal_fg\"/g" "$dunst_file"
    sed -i "/^\[urgency_critical\]/,/^\[/ s/^    foreground = .*/    foreground = \"$normal_fg\"/g" "$dunst_file"
}

update_dunst_colors

# Setting VS Code extension based on theme selection
case "$theme" in
    Catppuccin)
        vscodeTheme="Catppuccin Mocha"
        ;;
    Everforest)
        vscodeTheme="Everforest Dark"
        ;;
    Gruvbox)
        vscodeTheme="Gruvbox Dark Soft"
        ;;
    Neon)
        vscodeTheme="Neon Dark Theme"
        ;;
    TokyoNight)
        vscodeTheme="Tokyo Storm Gogh"
        ;;
    *)
        echo "Warning: Unknown theme selected. No changes applied."
        exit 1
        ;;
esac

# Modify VS Code settings.json
settingsFile="$HOME/.config/Code/User/settings.json"

# Ensure the settings file exists
if [[ ! -f "$settingsFile" ]]; then
    echo "[ ERROR ] VS Code settings file not found at $settingsFile"
    exit 1
fi

# Update or add the color theme setting in settings.json
sed -i "s|\"workbench.colorTheme\": \".*\"|\"workbench.colorTheme\": \"$vscodeTheme\"|" "$settingsFile"

"$scrDir/waybar-reload.sh" --reload
sleep 0.5
hyprctl reload
