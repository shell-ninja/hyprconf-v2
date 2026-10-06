local configs = require("confs.configs")
require("confs.tags")

-- floating
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(xfce-polkit)$" }, float = true, center = true })
hl.window_rule({ match = { tag = "file-manager", title = "File Operation Progress" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Tt]hunar)", title = "Confirm to replace files" }, float = true, center = true })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(nwg-look|qt5ct|qt6ct)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(kitty)$", title = "(update|floating|yazi|monitor|browser)" }, float = true, center = true })
hl.window_rule({ match = { class = "^(file-roller|org.gnome.FileRoller)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Kk]vantummanager)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Ll]xappearance)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(eog)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Tt]hunar)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Gg]nome-disks)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(org.kde.kcalc)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(org.telegram.desktop)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(org.kde.partitionmanager)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(org.kde.gwenview)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(brave-browser)$", title = "Messenger call" }, float = true, center = true })
hl.window_rule({ match = { class = "^(localsend)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(com.gabm.satty)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(org.gnome.Nautilus)$" }, float = true, center = true })

hl.window_rule({ match = { title = "^(Authentication Required)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(codium|codium-url-handler|VSCodium)", title = "(.*codium.*|.*VSCodium.*)" }, center = true })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$", title = "Heroic Games Launcher" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Ss]team)$", title = "^([Ss]team)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Tt]hunar)", title = "(.*[Tt]hunar.*)" }, float = true, center = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(electron)$", title = "^(Add Folder to Workspace)" }, float = true, center = true })
hl.window_rule({ match = { title = "^(Add Folder to Workspace)$" }, float = true, center = true })
hl.window_rule({ match = { tag = "browser", initial_title = "^(wants to open)$" }, float = true, center = true })
hl.window_rule({ match = { tag = "browser", initial_title = "^(Sign in - Google accounts)$" }, float = true, center = true })
hl.window_rule({ match = { initial_title = "^(Open Files)" }, float = true, center = true })

-- Shell Ninja GTK apps
hl.window_rule({ match = { class = "^(dev.shellninja.hypr-settings)$", title = "^(Hyprland Settings)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(dev.shellninja.pkgupdate)$" }, float = true, center = true, size = "(monitor_w*0.48) (monitor_h*0.80)" })
hl.window_rule({ match = { title = "^(System Update)$" }, float = true, center = true, size = "(monitor_w*0.48) (monitor_h*0.80)" })
hl.window_rule({ match = { class = "^(dev.shellninja.welcome)$" }, float = true, center = true, size = "(monitor_w*0.40) (monitor_h*0.80)" })

-- sizes
hl.window_rule({ match = { class = "^([Kk]vantummanager)$" }, size = "(monitor_w*0.55) (monitor_h*0.75)" })
hl.window_rule({ match = { class = "^([Ll]xappearance)$" }, size = "(monitor_w*0.55) (monitor_h*0.75)" })
hl.window_rule({ match = { class = "^(nwg-look)$" }, size = "(monitor_w*0.55) (monitor_h*0.75)" })
hl.window_rule({ match = { class = "^(eog)$" }, size = "(monitor_w*0.55) (monitor_h*0.75)" })
hl.window_rule({ match = { class = "^([Tt]hunar)$" }, size = "(monitor_w*0.55) (monitor_h*0.75)" })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, size = "(monitor_w*0.7) (monitor_h*0.7)" })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" }, size = "(monitor_w*0.6) (monitor_h*0.7)" })
hl.window_rule({ match = { class = "^(kitty)$", title = "(update)" }, size = "(monitor_w*0.7) (monitor_h*0.8)" })
hl.window_rule({ match = { class = "^(kitty)$", title = "(yazi)" }, size = "(monitor_w*0.6) (monitor_h*0.6)" })
hl.window_rule({ match = { class = "^(kitty)$", title = "(monitor)" }, size = "(monitor_w*0.5) (monitor_h*0.55)" })
hl.window_rule({ match = { class = "^(kitty)$", title = "(browser)" }, size = "(monitor_w*0.5) (monitor_h*0.6)" })
hl.window_rule({ match = { class = "^(kitty)$", title = "(floating)" }, size = "(monitor_w*0.55) (monitor_h*0.75)" })
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, size = "(monitor_w*0.5) (monitor_h*0.7)" })
hl.window_rule({ match = { class = "^(org.telegram.desktop)$" }, size = "(monitor_w*0.6) (monitor_h*0.8)" })
hl.window_rule({ match = { class = "^(org.kde.gwenview)$" }, size = "(monitor_w*0.6) (monitor_h*0.8)" })
hl.window_rule({ match = { class = "^(org.kde.partitionmanager)$" }, size = "(monitor_w*0.5) (monitor_h*0.6)" })
hl.window_rule({ match = { class = "^(org.kde.kcalc)$" }, size = "(monitor_w*0.3) (monitor_h*0.55)" })
hl.window_rule({ match = { class = "^(xfce-polkit)$" }, size = "(monitor_w*0.3) (monitor_h*0.2)" })
hl.window_rule({ match = { class = "^(localsend)$" }, size = "(monitor_w*0.4) (monitor_h*0.4)" })
hl.window_rule({ match = { class = "^(com.gabm.satty)$" }, size = "(monitor_w*0.6) (monitor_h*0.6)" })

-- position
hl.window_rule({ match = { class = "([Tt]hunar)", title = "(File Operation Progress)" }, center = true })
hl.window_rule({ match = { class = "([Tt]hunar)", title = "(Confirm to replace files)" }, center = true })
hl.window_rule({ match = { class = "^(nwg-look)$" }, center = true })
hl.window_rule({ match = { class = "^(qt5ct)$" }, center = true })
hl.window_rule({ match = { class = "^(lxappearance)$" }, center = true })
hl.window_rule({ match = { class = "^(yad)$" }, center = true })
hl.window_rule({ match = { class = "^(kitty)$", title = "(yazi|update|browser)" }, center = true })

-- opacity
hl.window_rule({ match = { tag = "file-manager" }, opacity = tostring(configs.opacity_act) .. " " .. tostring(configs.opacity_deact) })
hl.window_rule({ match = { tag = "browser" }, opacity = "1.0 " .. tostring(configs.opacity_deact) })

-- open in workspaces
hl.window_rule({ match = { class = "(kitty)$", title = "(main)" }, workspace = "1" })
hl.window_rule({ match = { tag = "browser" }, workspace = "2" })
hl.window_rule({ match = { tag = "ide" }, workspace = "3" })
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, workspace = "3" })

-- workspace rule
hl.workspace_rule({
    workspace = "special:exposed",
    gaps_out = 60,
    gaps_in = 30,
    border_size = 5,
    no_shadow = true,
})

-- layer rules
hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
hl.layer_rule({ match = { namespace = "gtk-layer-shell" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
