local configs = require("confs.configs")

local activeCol = "rgba(b4befecc)"
local inactiveCol = "rgba(6c7086cc)"
local icon = "Catppuccin-Mocha"
local theme = "Catppuccin"
local color = "perfect-dark"

hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme " .. icon)
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme " .. theme)
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme " .. color)

hl.config({
    general = {
        layout = "dwindle",
        gaps_in = configs.inner_gap,
        gaps_out = configs.outer_gap,
        border_size = configs.border,
        col = {
            active_border = activeCol,
            inactive_border = inactiveCol,
        },
        resize_on_border = false,
        allow_tearing = false,
    },

    decoration = {
        rounding = configs.rounding,
        rounding_power = 2,
        fullscreen_opacity = 1.0,
        dim_strength = 0.1,
        dim_special = 0.8,

        shadow = {
            enabled = false,
            range = configs.shadow_range,
            render_power = 4,
            color = activeCol,
            color_inactive = inactiveCol,
        },

        blur = {
            enabled = true,
            size = configs.blur_size,
            passes = configs.blur_pass,
            ignore_opacity = true,
            new_optimizations = true,
            special = true,
            popups = true,
        },
    },
})

return {
    activeCol = activeCol,
    inactiveCol = inactiveCol,
    icon = icon,
    theme = theme,
    color = color,
}
