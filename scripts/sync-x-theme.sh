#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "${script_dir}/.." && pwd)"

theme_name="X"
asset_exts=(png jpg jpeg gif)

src_hypr_theme="${repo_root}/config/hypr/confs/themes/${theme_name}.conf"
src_kitty_colors="${repo_root}/config/kitty/colors/${theme_name}.conf"
src_kitty_conf="${repo_root}/config/kitty/kitty.conf"
src_rofi_colors="${repo_root}/config/rofi/colors/${theme_name}.rasi"
src_waybar_colors="${repo_root}/config/waybar/colors/${theme_name}.css"
src_wlogout_colors="${repo_root}/config/wlogout/colors/${theme_name}.css"
src_swaync_colors="${repo_root}/config/swaync/colors/${theme_name}.css"
src_assets_dir="${repo_root}/config/hypr/assets"
src_wallpapers_dir_upper="${repo_root}/config/hypr/Wallpapers/${theme_name}"
src_wallpapers_dir_lower="${repo_root}/config/hypr/Wallpapers/${theme_name,,}"

dst_hypr_theme="$HOME/.config/hypr/confs/themes/${theme_name}.conf"
dst_kitty_colors="$HOME/.config/kitty/colors/${theme_name}.conf"
dst_kitty_conf="$HOME/.config/kitty/kitty.conf"
dst_rofi_colors="$HOME/.config/rofi/colors/${theme_name}.rasi"
dst_waybar_colors="$HOME/.config/waybar/colors/${theme_name}.css"
dst_wlogout_colors="$HOME/.config/wlogout/colors/${theme_name}.css"
dst_swaync_colors="$HOME/.config/swaync/colors/${theme_name}.css"
dst_assets_dir="$HOME/.config/hypr/assets"
dst_wallpapers_dir="$HOME/.config/hypr/Wallpapers/${theme_name}"
dst_theme_cache="$HOME/.config/hypr/.cache/.theme"

ensure_parent_dir() {
    local target="$1"
    mkdir -p "$(dirname -- "$target")"
}

copy_file() {
    local src="$1"
    local dst="$2"

    if [[ ! -f "$src" ]]; then
        echo "[WARN] Missing source: $src"
        return 0
    fi

    ensure_parent_dir "$dst"
    cp -f "$src" "$dst"
    echo "[OK] $src -> $dst"
}

copy_file "$src_hypr_theme" "$dst_hypr_theme"
copy_file "$src_kitty_colors" "$dst_kitty_colors"
copy_file "$src_kitty_conf" "$dst_kitty_conf"
copy_file "$src_rofi_colors" "$dst_rofi_colors"
copy_file "$src_waybar_colors" "$dst_waybar_colors"
copy_file "$src_wlogout_colors" "$dst_wlogout_colors"

if [[ -d "$HOME/.config/swaync" || -f "$src_swaync_colors" ]]; then
    copy_file "$src_swaync_colors" "$dst_swaync_colors"
fi

find_asset() {
    local base="$1"
    local dir="$2"

    for ext in "${asset_exts[@]}"; do
        if [[ -f "${dir}/${base}.${ext}" ]]; then
            echo "${dir}/${base}.${ext}"
            return 0
        fi
        if [[ -f "${dir}/${base,,}.${ext}" ]]; then
            echo "${dir}/${base,,}.${ext}"
            return 0
        fi
    done

    return 1
}

clean_asset_targets() {
    local base="$1"
    local dir="$2"

    for ext in "${asset_exts[@]}"; do
        rm -f "${dir}/${base}.${ext}" "${dir}/${base,,}.${ext}"
    done
}

if src_asset=$(find_asset "$theme_name" "$src_assets_dir"); then
    clean_asset_targets "$theme_name" "$dst_assets_dir"
    ensure_parent_dir "$dst_assets_dir/${theme_name}.${src_asset##*.}"
    cp -f "$src_asset" "$dst_assets_dir/${theme_name}.${src_asset##*.}"
    echo "[OK] $src_asset -> $dst_assets_dir/${theme_name}.${src_asset##*.}"
else
    echo "[WARN] No asset found in $src_assets_dir for $theme_name"
fi

if [[ -d "$src_wallpapers_dir_upper" || -d "$src_wallpapers_dir_lower" ]]; then
    mkdir -p "$dst_wallpapers_dir"
    if [[ -d "$src_wallpapers_dir_upper" ]]; then
        cp -rf "$src_wallpapers_dir_upper"/* "$dst_wallpapers_dir"/
    else
        cp -rf "$src_wallpapers_dir_lower"/* "$dst_wallpapers_dir"/
    fi
    echo "[OK] Wallpapers synced to $dst_wallpapers_dir"
else
    echo "[WARN] No wallpapers found for $theme_name in repo"
fi

mkdir -p "$(dirname -- "$dst_theme_cache")"
echo "$theme_name" > "$dst_theme_cache"

ln -sf "$dst_hypr_theme" "$HOME/.config/hypr/confs/decoration.conf"
ln -sf "$dst_rofi_colors" "$HOME/.config/rofi/themes/rofi-colors.rasi"
ln -sf "$dst_kitty_colors" "$HOME/.config/kitty/theme.conf"
ln -sf "$dst_waybar_colors" "$HOME/.config/waybar/style/theme.css"
ln -sf "$dst_wlogout_colors" "$HOME/.config/wlogout/colors.css"

if [[ -d "$HOME/.config/swaync" ]]; then
    ln -sf "$dst_swaync_colors" "$HOME/.config/swaync/colors.css"
fi

if pids=$(pidof kitty 2>/dev/null) && [[ -n "$pids" ]]; then
    kill -SIGUSR1 $pids
fi

echo "Done. Theme X files synced to ~/.config."
