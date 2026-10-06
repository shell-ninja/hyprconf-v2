#!/bin/bash

config_file="$HOME/.config/hypr/confs/monitor.conf"
config_lua="$HOME/.config/hypr/confs/monitor.lua"

# Fallback check if old configs dir exists
if [[ ! -f "$config_file" && -f "$HOME/.config/hypr/configs/monitor.conf" ]]; then
    config_file="$HOME/.config/hypr/configs/monitor.conf"
fi

auto_generated_setting=""
if [[ -f "$config_file" ]]; then
    auto_generated_setting=$(grep "monitor=, preferred, auto, 1" "$config_file" 2>/dev/null || true)
fi

auto_generated_lua=""
if [[ -f "$config_lua" ]]; then
    auto_generated_lua=$(grep 'mode[[:space:]]*=[[:space:]]*"preferred"' "$config_lua" 2>/dev/null || true)
fi

display() {
    cat << "EOF"
   __  ___          _ __             ____    __          
  /  |/  /__  ___  (_) /____  ____  / __/__ / /___ _____ 
 / /|_/ / _ \/ _ \/ / __/ _ \/ __/ _\ \/ -_) __/ // / _ \
/_/  /_/\___/_//_/_/\__/\___/_/   /___/\__/\__/\_,_/ .__/
                                                  /_/    
EOF
}

if [[ -n "$auto_generated_setting" || -n "$auto_generated_lua" ]]; then

    gum spin \
        --spinner minidot \
        --spinner.foreground "#eabbd1" \
        --title.foreground "#eabbd1" \
        --title "Setting up for your Monitor" -- \
        sleep 2

    monitor_name=$(xrandr | grep "connected" | awk '{print $1}' | head -n 1)
    monitor_resolution=$(xrandr | grep "connected" | awk '{print $3}' | cut -d'+' -f1 | head -n 1)

    display
    refresh_rate=$(gum choose \
                    --header \
                    "󰍹 Choose the refresh rate for your '$monitor_name' monitor:" \
                    --header.foreground "#eabbd1" \
                    --selected.foreground "#eabbd1" \
                    --cursor.foreground "#eabbd1" \
                    "60Hz" "75Hz" "120Hz" "144Hz" "165Hz" "180Hz" "200Hz" "240Hz"
                )

    hz=""
    case $refresh_rate in
        60Hz) hz="60" ;;
        75Hz) hz="75" ;;
        120Hz) hz="120" ;;
        144Hz) hz="144" ;;
        165Hz) hz="165" ;;
        180Hz) hz="180" ;;
        200Hz) hz="200" ;;
        240Hz) hz="240" ;;
        *)
            echo -e ">< Nothing will be changed. Exiting.."
            exit 0
            ;;
    esac

    settings="monitor=${monitor_name},${monitor_resolution}@${hz}, 0x0, 1"

    if [[ -f "$config_file" && -n "$auto_generated_setting" ]]; then
        sed -i "s/$auto_generated_setting/$settings/" "$config_file"
    fi

    if [[ -f "$config_lua" ]]; then
        cat << EOF > "$config_lua"
hl.monitor({
    output   = "${monitor_name}",
    mode     = "${monitor_resolution}@${hz}",
    position = "0x0",
    scale    = "1",
})
EOF
    fi
fi
