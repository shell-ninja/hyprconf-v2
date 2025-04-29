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

# set swaync colors
swayncTheme="$HOME/.config/swaync/colors/${theme}.css"
ln -sf "$swayncTheme" "$HOME/.config/swaync/colors.css"


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
else
    sed -i "s|\"workbench.colorTheme\": \".*\"|\"workbench.colorTheme\": \"$vscodeTheme\"|" "$settingsFile"
fi

"$scrDir/Refresh.sh" &> /dev/null
