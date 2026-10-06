#!/bin/bash

# apps.sh — Open web apps / websites with preferred browser

open_site() {
    local site_name=$1
    local url=""

    if [[ "$site_name" =~ ^https?:// ]]; then
        url="$site_name"
    elif [[ "$site_name" == *"."* ]]; then
        url="https://${site_name}"
    else
        case "$site_name" in
            fb|facebook)        url="https://www.facebook.com" ;;
            yt|youtube)         url="https://www.youtube.com" ;;
            ai|chatgpt)         url="https://chatgpt.com" ;;
            gem|gemini)         url="https://gemini.google.com/app" ;;
            wapp|whatsapp)      url="https://web.whatsapp.com" ;;
            github)             url="https://github.com" ;;
            ps|photopea)        url="https://www.photopea.com/" ;;
            *)                  url="https://${site_name}.com" ;;
        esac
    fi

    browser_cache="$HOME/.config/hypr/.cache/.browser"
    browser=$(grep "default" "$browser_cache" 2>/dev/null | awk -F'=' '{print $2}')
    [ -z "$browser" ] && browser="brave"

    if [[ ! "$browser" == "firefox" && ! "$browser" == "zen-browser" ]]; then
        "$browser" --app="$url"
    else
        "$browser" --new-window "$url"
    fi
}

open_site "$1"
