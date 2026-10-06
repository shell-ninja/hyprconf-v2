local home = os.getenv("HOME")
local scripts_dir = home .. "/.config/hypr/scripts"
local cursor = "layan-white-cursors"

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor " .. cursor .. " 24")
    hl.exec_cmd(scripts_dir .. "/startup.sh")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("swaync")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd(scripts_dir .. "/polkit.sh")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("pypr")
    hl.exec_cmd(scripts_dir .. "/welcome.py --autostart")
end)
