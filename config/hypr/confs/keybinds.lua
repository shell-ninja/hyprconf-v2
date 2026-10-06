local mainMod = "SUPER"

local home = os.getenv("HOME")
local scriptsDir = home .. "/.config/hypr/scripts"
local wallpaper = scriptsDir .. "/Wallpaper.sh"
local wallpaperSelect = scriptsDir .. "/WallpaperSelect.sh"
local power_menu = scriptsDir .. "/powermenu.sh"
local terminal = "kitty"
local file_man = "dolphin"
local terminal_file_man = "yazi"
local rofi_emoji = scriptsDir .. "/rofi-emoji.sh"
local help = scriptsDir .. "/keybinds.sh"
local volumeCTRL = scriptsDir .. "/volumecontrol.sh"
local apps = scriptsDir .. "/apps.sh"

-- Change Wallpaper
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(wallpaper))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(wallpaperSelect .. " thm1"))
hl.bind(mainMod .. " + CTRL + SHIFT + W", hl.dsp.exec_cmd(wallpaperSelect .. " thm2"))

-- Screenshot
hl.bind("print", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh"))

-- Key Binds Help
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd(help))

-- Terminal & App Launchers
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal .. " --title main"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal .. " --title floating"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(file_man))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("kitty --title " .. terminal_file_man .. " -e " .. terminal_file_man))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(scriptsDir .. "/menu.sh || pkill rofi"))
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd(scriptsDir .. "/rofi_theme.sh"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(scriptsDir .. "/cliphist.sh c"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(scriptsDir .. "/cliphist.sh w"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(rofi_emoji))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("code"))

-- Session / Power
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(scriptsDir .. "/wlogout.sh 2"))
-- hl.bind(mainMod .. " + ALT + X", hl.dsp.exec_cmd(scriptsDir .. "/wlogout.sh 1"))

-- Browsers & System
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(scriptsDir .. "/browser.sh op"))
hl.bind("ALT + B", hl.dsp.exec_cmd(scriptsDir .. "/default_browser.sh --reset"))
hl.bind("CTRL + ESCAPE", hl.dsp.exec_cmd(scriptsDir .. "/waybar-reload.sh --reload"))
hl.bind("CTRL + ALT + ESCAPE", hl.dsp.exec_cmd(scriptsDir .. "/waybar-reload.sh --toggle"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/hyprlock.sh"))
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd(scriptsDir .. "/toggle_dark_light.sh"))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd(scriptsDir .. "/waybar-layout.sh"))
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd('hyprctl reload && notify-send "Done" "Hyprland reload"'))
hl.bind("CTRL + U", hl.dsp.exec_cmd(scriptsDir .. "/pkgupdate-gui.py"))
hl.bind(mainMod .. " + CTRL + U", hl.dsp.exec_cmd('kitty --title browser sh -c "' .. scriptsDir .. '/hyprconf-v2.sh"'))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scriptsDir .. "/startup.sh &> /dev/null"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(scriptsDir .. "/settings.py &> /dev/null || kitty --title browser sh -c '" .. scriptsDir .. "/settings.sh'"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('kitty --title browser sh -c "' .. scriptsDir .. '/settings.sh"'))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(scriptsDir .. "/theme_select.sh"))
hl.bind(mainMod .. " + ALT + U", hl.dsp.exec_cmd('kitty sh -c "' .. scriptsDir .. '/uninstall.sh"'))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd('notify-send "Colors" "Re-generating colors." && ' .. scriptsDir .. '/pywal.sh'))
hl.bind("F8", hl.dsp.exec_cmd(scriptsDir .. "/secure_mode.sh"))

-- Switch window / Rofi
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("rofi -show window -theme ~/.config/rofi/themes/rofi-window.rasi"))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top())
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl dispatch splitratio 0.3"))

-- Audio control
hl.bind("F9", hl.dsp.exec_cmd(volumeCTRL .. " --toggle"), { locked = true })
hl.bind("F10", hl.dsp.exec_cmd(volumeCTRL .. " --dec"), { locked = true, repeating = true })
hl.bind("F11", hl.dsp.exec_cmd(volumeCTRL .. " --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volumeCTRL .. " --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volumeCTRL .. " --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(volumeCTRL .. " --toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(volumeCTRL .. " --toggle-mic"), { locked = true })

-- Animations & Night light
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(scriptsDir .. "/animations_toggle.sh"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(scriptsDir .. "/nightlight.sh --dec"))
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd(scriptsDir .. "/nightlight.sh --inc"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd(scriptsDir .. "/nightlight.sh --def"))

-- Brightness
hl.bind("F4", hl.dsp.exec_cmd(scriptsDir .. "/brightness.sh up"), { locked = true, repeating = true })
hl.bind("F3", hl.dsp.exec_cmd(scriptsDir .. "/brightness.sh down"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUP", hl.dsp.exec_cmd(scriptsDir .. "/brightness.sh up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDOWN", hl.dsp.exec_cmd(scriptsDir .. "/brightness.sh down"), { locked = true, repeating = true })

-- Web Apps Quick-Launch
hl.bind("ALT + A", hl.dsp.exec_cmd(apps .. " chatgpt"))
hl.bind("CTRL + ALT + A", hl.dsp.exec_cmd(apps .. " gemini.google"))
hl.bind("CTRL + ALT + G", hl.dsp.exec_cmd(apps .. " grok"))
hl.bind("ALT + F", hl.dsp.exec_cmd(apps .. " facebook"))
hl.bind("ALT + Y", hl.dsp.exec_cmd(apps .. " youtube"))
hl.bind("ALT + W", hl.dsp.exec_cmd(apps .. " web.whatsapp"))
hl.bind("ALT + I", hl.dsp.exec_cmd(apps .. " instagram"))
hl.bind("ALT + G", hl.dsp.exec_cmd(apps .. " github"))
hl.bind("ALT + R", hl.dsp.exec_cmd(apps .. " reddit"))

-- Move focus (Vim keys)
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))

-- Move active window around current workspace
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }))

-- Switch workspaces 1-10
for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Pyprland
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pypr expose"))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.exec_cmd("pypr change_workspace -1"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("pypr change_workspace +1"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("pypr toggle_special minimized"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.workspace.toggle_special("minimized"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("pypr shift_monitors +1"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("pypr zoom ++0.5"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pypr zoom"))

-- Desktop zooming
hl.bind(mainMod .. " + ALT + mouse_down", hl.dsp.exec_cmd('hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk \'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor * 2.0}\')"'))
hl.bind(mainMod .. " + ALT + mouse_up", hl.dsp.exec_cmd('hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk \'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor / 2.0}\')"'))
