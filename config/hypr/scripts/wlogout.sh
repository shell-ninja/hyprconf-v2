#!/usr/bin/env bash

# ─────────────────────────────────────────────────────────────────────────────
# wlogout.sh — wlogout launcher with monitor-aware layout
# ─────────────────────────────────────────────────────────────────────────────

# Toggle: kill if already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Determine configuration directory
if [[ -d "$HOME/.config/wlogout" ]]; then
    export CONF_DIR="$HOME/.config/wlogout"
else
    # Fallback to repository directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    export CONF_DIR="$(cd "$SCRIPT_DIR/../../wlogout" 2>/dev/null && pwd || echo "$HOME/.config/wlogout")"
fi

STYLE="${1:-2}"

# Support both naming conventions (layout_1 / layout, style_1.css / style.css)
if [[ -f "$CONF_DIR/layout_${STYLE}" ]]; then
    wLayout="$CONF_DIR/layout_${STYLE}"
elif [[ -f "$CONF_DIR/layout" && "$STYLE" == "1" ]]; then
    wLayout="$CONF_DIR/layout"
else
    wLayout="$CONF_DIR/layout_2"
    STYLE=2
fi

if [[ -f "$CONF_DIR/style_${STYLE}.css" ]]; then
    wlTmplt="$CONF_DIR/style_${STYLE}.css"
elif [[ -f "$CONF_DIR/style.css" && "$STYLE" == "1" ]]; then
    wlTmplt="$CONF_DIR/style.css"
else
    wlTmplt="$CONF_DIR/style_2.css"
    STYLE=2
fi

# ── Monitor resolution (focused) ──────────────────────────────────────────────
MON_JSON=$(hyprctl -j monitors 2>/dev/null)

if [[ -n "$MON_JSON" && "$MON_JSON" != "null" ]]; then
    x_mon=$(echo "$MON_JSON" | jq -r '.[] | select(.focused==true) | .width' 2>/dev/null | head -n1)
    y_mon=$(echo "$MON_JSON" | jq -r '.[] | select(.focused==true) | .height' 2>/dev/null | head -n1)
    scale_raw=$(echo "$MON_JSON" | jq -r '.[] | select(.focused==true) | .scale' 2>/dev/null | head -n1)
fi

x_mon="${x_mon:-1920}"
y_mon="${y_mon:-1080}"
scale=$(awk -v s="${scale_raw:-1}" 'BEGIN{printf "%d", (s*100)+0.5}')
[ -z "$scale" ] || [ "$scale" -le 0 ] && scale=100

case "$STYLE" in
    *1)
        wlColms=6
        export mgn=$((y_mon * 28 / scale))
        export hvr=$((mgn * 80 / 100))
        ;;
    2)
        wlColms=2
        export x_mgn=$((x_mon * 35 / scale))
        export y_mgn=$((y_mon * 25 / scale))
        [ "$x_mgn" -gt "$x_mon" ] && x_mgn=$x_mon
        [ "$y_mgn" -gt "$y_mon" ] && y_mgn=$y_mon
        export x_hvr=$((x_mgn * 80 / 100))
        export y_hvr=$((y_mgn * 80 / 100))
        export win_w=$((x_mgn * 2 + 40))
        export win_h=$((y_mgn * 2 + 40))
        ;;
    *)
        wlColms=2
        export x_mgn=$((x_mon * 35 / scale))
        export y_mgn=$((y_mon * 25 / scale))
        [ "$x_mgn" -gt "$x_mon" ] && x_mgn=$x_mon
        [ "$y_mgn" -gt "$y_mon" ] && y_mgn=$y_mon
        export x_hvr=$((x_mgn * 80 / 100))
        export y_hvr=$((y_mgn * 80 / 100))
        ;;
esac

# ── Font size ─────────────────────────────────────────────────────────────────
export fntSize=$((y_mon * 2 / 100))
[ "$fntSize" -lt 14 ] && fntSize=14

# ── Border radius from Hyprland ───────────────────────────────────────────────
hypr_border=$(hyprctl getoption "decoration:rounding" 2>/dev/null \
    | awk '/^int:/{print $2}' | head -n1)
hypr_border="${hypr_border:-10}"

export active_rad=$((hypr_border * 5))
export button_rad=$((hypr_border * 8))

# ── Generate CSS with expanded variables and colors ───────────────────────────
colors_file="$CONF_DIR/colors.css"
if [[ ! -f "$colors_file" ]]; then
    colors_file="$CONF_DIR/colors/Catppuccin.css"
fi

tmp_css="/tmp/wlogout-${UID:-0}-style.css"
cat "$colors_file" "$wlTmplt" | envsubst > "$tmp_css"

# ── Launch wlogout ────────────────────────────────────────────────────────────
wlogout -b "$wlColms" -c 0 -r 0 -m 0 \
    --layout "$wLayout" \
    --css "$tmp_css" \
    --protocol layer-shell
