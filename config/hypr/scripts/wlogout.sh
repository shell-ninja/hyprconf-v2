#!/usr/bin/env bash

# ─────────────────────────────────────────────────────────────────────────────
# wlogout.sh — wlogout launcher with monitor-aware layout
# ─────────────────────────────────────────────────────────────────────────────

# Kill any already-running instance and exit
if pgrep -x "wlogout" >/dev/null; then
    pkill -x "wlogout"
    exit 0
fi

CONF_DIR="$HOME/.config/wlogout"
STYLE="${1:-2}"

wLayout="$CONF_DIR/layout_${STYLE}"
wlStyle="$CONF_DIR/style_${STYLE}.css"

if [ ! -f "$wLayout" ]; then
    echo "Error: Layout file not found at $wLayout"
    exit 1
fi

# ── Monitor dimensions ───────────────────────────────────────────────────────
# Get dimensions of the focused monitor using hyprctl
read -r x_mon y_mon < <(
    hyprctl -j monitors | jq -r '
        .[] | select(.focused == true)
        | "\(.width) \(.height)"
    '
)

# ── Scaling ──────────────────────────────────────────────────────────────────
# Get the raw float scale (e.g. 1, 1.5, 2) and convert to a fixed *100 integer.
scale_raw=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .scale' 2>/dev/null || echo "1")
scale=$(awk -v s="$scale_raw" 'BEGIN{printf "%d", (s*100)+0.5}')
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
        export win_w=$((x_mgn * 2 + 40))
        export win_h=$((y_mgn * 2 + 40))
        ;;
esac

# ── Launch ───────────────────────────────────────────────────────────────────
wlogout \
    -b "$wlColms" \
    -c 0 \
    -r 0 \
    -m 0 \
    --layout "$wLayout" \
    --css    "$wlStyle" \
    --protocol layer-shell
