#!/bin/bash

# Advanced Hyprland Installation Script by
# Shell Ninja ( https://github.com/shell-ninja )

# color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
megenta="\e[1;1;35m"
cyan="\e[1;36m"
orange="\x1b[38;5;214m"
end="\e[1;0m"

if command -v gum &> /dev/null; then

display_text() {
    gum style \
        --border rounded \
        --align center \
        --width 60 \
        --margin "1" \
        --padding "1" \
'
   __ __                            ___
  / // /_ _____  ___________  ___  / _/
 / _  / // / _ \/ __/ __/ _ \/ _ \/ _/ 
/_//_/\_, / .__/_/  \__/\___/_//_/_/   
     /___/_/                                
'
}

else
display_text() {
    cat << "EOF"
   __ __                            ___
  / // /_ _____  ___________  ___  / _/
 / _  / // / _ \/ __/ __/ _ \/ _ \/ _/ 
/_//_/\_, / .__/_/  \__/\___/_//_/_/   
     /___/_/                              

EOF
}
fi

clear && display_text
printf " \n \n"

###------ Startup ------###

# finding the presend directory and log file
# dir="$(dirname "$(realpath "$0")")"
dir=`pwd`
# log directory
log_dir="$dir/Logs"
log="$dir/Logs/hyprconf-v2.log"
mkdir -p "$log_dir"
touch "$log"

# message prompts
msg() {
    local actn=$1
    local msg=$2

    case $actn in
        act)
            printf "${green}=>${end} $msg\n"
            ;;
        ask)
            printf "${orange}??${end} $msg\n"
            ;;
        dn)
            printf "${cyan}::${end} $msg\n\n"
            ;;
        att)
            printf "${yellow}!!${end} $msg\n"
            ;;
        nt)
            printf "${blue}\$\$${end} $msg\n"
            ;;
        skp)
            printf "${magenta}[ SKIP ]${end} $msg\n"
            ;;
        err)
            printf "${red}>< Ohh sheet! an error..${end}\n   $msg\n"
            sleep 1
            ;;
        *)
            printf "$msg\n"
            ;;
    esac
}


# Directories ----------------------------
hypr_dir="$HOME/.config/hypr"
scripts_dir="$hypr_dir/scripts"
# fonts_dir="$HOME/.local/share/fonts"

msg act "Now setting up the pre installed Hyprland configuration..."sleep 1

mkdir -p ~/.config
dirs=(
    btop
    dunst
    fastfetch
    fish
    gtk-3.0
    gtk-4.0
    hypr
    kitty
    Kvantum
    nvim
    nwg-look
    qt5ct
    qt6ct
    rofi
    waybar
    xsettingsd
    yazi
)


# if some main directories exists, backing them up.
if [[ -d "$HOME/.config/backup_hyprconfV2-${USER}" ]]; then
    msg att "a backup_hyprconfV2-${USER} directory was there. Archiving it..."
    cd "$HOME/.config"
    mkdir -p "archive_hyprconfV2-${USER}"
    tar -czf "archive_hyprconfV2-${USER}/backup_hyprconfV2-$(date +%d-%m-%Y_%I-%M-%p)-${USER}.tar.gz" "backup_hyprconfV2-${USER}" &> /dev/null
    rm -rf "backup_hyprconfV2-${USER}"
    msg dn "backup_hyprconfV2-${USER} was archived inside archive_hyprconfV2-${USER} directory..." && sleep 1
fi

for confs in "${dirs[@]}"; do
    mkdir -p "$HOME/.config/backup_hyprconfV2-${USER}"
    dir_path="$HOME/.config/$confs"
    if [[ -d "$dir_path" ]]; then
        mv "$dir_path" "$HOME/.config/backup_hyprconfV2-${USER}/" 2>&1 | tee -a "$log"
    fi
done

[[ -d "$HOME/.config/backup_hyprconfV2-${USER}/hypr" ]] && msg dn "Everything has been backuped in $HOME/.config/backup_hyprconfV2-${USER}..."

sleep 1


####################################################################

#_____ if OpenBangla Keyboard is installed
# keyboard_path="/usr/share/openbangla-keyboard"
#
# if [[ -d "$keyboard_path" ]]; then
#     msg act "Setting up OpenBangla-Keyboard..."
#
#     # Add fcitx5 environment variables to /etc/environment if not already present
#     if ! grep -q "GTK_IM_MODULE=fcitx" /etc/environment; then
#         printf "\nGTK_IM_MODULE=fcitx\n" | sudo tee -a /etc/environment 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") &> /dev/null
#     fi
#
#     if ! grep -q "QT_IM_MODULE=fcitx" /etc/environment; then
#         printf "QT_IM_MODULE=fcitx\n" | sudo tee -a /etc/environment 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") &> /dev/null
#     fi
#
#     if ! grep -q "XMODIFIERS=@im=fcitx" /etc/environment; then
#         printf "XMODIFIERS=@im=fcitx\n" | sudo tee -a /etc/environment 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") &> /dev/null
#     fi
#
# fi

####################################################################


#_____ for virtual machine
# Check if the configuration is in a virtual box
if hostnamectl | grep -q 'Chassis: vm'; then
    msg att "You are using this script in a Virtual Machine..."
    msg act "Setting up things for you..." 
    sed -i '/env = WLR_NO_HARDWARE_CURSORS,1/s/^#//' "$dir/config/hypr/confs/env.conf"
    sed -i '/env = WLR_RENDERER_ALLOW_SOFTWARE,1/s/^#//' "$dir/config/hypr/confs/env.conf"
    mv "$dir/config/hypr/confs/monitor.conf" "$dir/config/hypr/confs/monitor-back.conf"
    cp "$dir/config/hypr/confs/monitor-vbox.conf" "$dir/config/hypr/confs/monitor.conf"
fi


#_____ for nvidia gpu. I don't know if it's gonna work or not. Because I don't have any gpu.
# uncommenting WLR_NO_HARDWARE_CURSORS if nvidia is detected
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
  msg act "Nvidia GPU detected. Setting up proper env's" 2>&1 | tee -a >(sed 's/\x1B\[[0-9;]*[JKmsu]//g' >> "$log") || true
  sed -i '/env = WLR_NO_HARDWARE_CURSORS,1/s/^#//' config/hypr/configs/environment.conf
  sed -i '/env = LIBVA_DRIVER_NAME,nvidia/s/^#//' config/hypr/configs/environment.conf
  sed -i '/env = __GLX_VENDOR_LIBRARY_NAME,nvidia/s/^# //' config/hypr/configs/environment.conf
fi

sleep 1


#####################################################
# cloning the dotfiles repository into ~/.config/hypr
#####################################################

mkdir -p "$HOME/.config"
cp -r "$dir/config"/* "$HOME/.config/" && sleep 0.5
if [[ ! -d "$HOME/.local/share/fastfetch" ]]; then
    mv "$HOME/.config/fastfetch" "$HOME/.local/share/"
fi


sleep 1

if [[ -d "$scripts_dir" ]]; then
    # make all the scripts executable...
    chmod +x "$scripts_dir"/* 2>&1 | tee -a "$log"
    chmod +x "$HOME/.config/fish"/* 2>&1 | tee -a "$log"
    msg dn "All the necessary scripts have been executable..."
    sleep 1
else
    msg err "Could not find necessary scripts.."
fi

# Install Fonts
# msg act "Installing some fonts..."
# if [[ ! -d "$fonts_dir" ]]; then
# 	mkdir -p "$fonts_dir"
# fi
#
# cp -r "$dir/extras/fonts" "$fonts_dir"
# msg act "Updating font cache..."
# sudo fc-cache -fv 2>&1 | tee -a "$log" &> /dev/null


wayland_session_dir=/usr/share/wayland-sessions
if [ -d "$wayland_session_dir" ]; then
    msg att "$wayland_session_dir found..."
else
    msg att "$wayland_session_dir NOT found, creating..."
    sudo mkdir $wayland_session_dir 2>&1 | tee -a "$log"
    sudo cp "$dir/extras/hyprland.desktop" /usr/share/wayland-sessions/ 2>&1 | tee -a "$log"
fi


############################################################
# themes and icons
###########################################################
assetsDir="$dir/assets"
mkdir -p ~/.icons
mkdir -p ~/.themes

parallel --bar "tar xzf {} -C ~/.icons/ --strip-components=1" ::: $assetsDir/icons/*.tar.gz
parallel --bar "tar xzf {} -C ~/.themes/ --strip-components=1" ::: $assetsDir/themes/*.tar.gz

# vs code
if [[ -d "$HOME/.config/Code" ]]; then 
    mv "$HOME/.config/Code" "$HOME/.config/Code-Back-$(date +%d-%m-%Y_%I-%M-%p)"
fi
cp -r "$assetsDir/Code" "$HOME/.config/"

if [[ -d "$HOME/.vscode/" ]]; then 
    mv "$HOME/.vscode" "$HOME/.vscode-back-$(date +%d-%m-%Y_%I-%M-%p)"
fi
cp -r "$assetsDir/.vscode" "$HOME/"



############################################################
# setting theme
###########################################################
# setting up the waybar
ln -sf "$HOME/.config/waybar/configs/full-top" "$HOME/.config/waybar/config"
ln -sf "$HOME/.config/waybar/style/full-top.css" "$HOME/.config/waybar/style.css"

# setting up hyprlock theme
# ln -sf "$HOME/.config/hypr/lockscreens/hyprlock-1.conf" "$HOME/.config/hypr/hyprlock.conf"


themeFile="$HOME/.config/hypr/.cache/.theme"
touch "$themeFile" && echo "Catppuccin" > "$themeFile"

"$HOME/.config/config/hypr/scripts/Wallpaper.sh" &> /dev/null
"$HOME/.config/config/hypr/scripts/Refresh.sh" &> /dev/null

# hyprland themes
hyprTheme="$HOME/.config/hypr/confs/themes/Catppuccin.conf"
ln -sf "$hyprTheme" "$HOME/.config/hypr/confs/decoration.conf"

# rofi themes
rofiTheme="$HOME/.config/rofi/colors/Catppuccin.rasi"
ln -sf "$rofiTheme" "$HOME/.config/rofi/themes/rofi-colors.rasi"

# Kitty themes
kittyTheme="$HOME/.config/kitty/colors/Catppuccin.conf"
ln -sf "$kittyTheme" "$HOME/.config/kitty/theme.conf"

# Apply new colors dynamically
kill -SIGUSR1 $(pidof kitty)

# waybar themes
waybarTheme="$HOME/.config/waybar/colors/Catppuccin.css"
ln -sf "$waybarTheme" "$HOME/.config/waybar/style/theme.css"


# ----- Dunst
dunst_file="$HOME/.config/dunst/dunstrc"
colors_file="$HOME/.config/kitty/colors/Catppuccin.conf"

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
settingsFile="$HOME/.config/Code/User/settings.json"
sed -i "s|\"workbench.colorTheme\": \".*\"|\"workbench.colorTheme\": \"Catppuccin Mocha\"|" "$settingsFile"

"$HOME/.config/hypr/scripts/wallcache.sh" &> /dev/null

#############################################
# setting lock screen
#############################################
ln -sf "$HOME/.config/hypr/lockscreens/hyprlock-1.conf" "$HOME/.config/hypr/hyprlock.conf"

msg dn "Script execution was successful! Now logout and log back in and enjoy your customization..." && sleep 1
msg att "Logging out..." && sleep 2
# hyprctl dispatch exit 1

# === ___ Script Ends Here ___ === #
