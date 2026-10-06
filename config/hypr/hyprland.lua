-------------------------------------------------------
-- HYPRCONF VERSION 2 - HYPRLAND CONFIGURATION (LUA) --
-- By Shell Ninja (https://github.com/shell-ninja)    --
-------------------------------------------------------

local home = os.getenv("HOME") or ""
local hypr_dir = home .. "/.config/hypr"
local info = debug.getinfo(1, "S")
local script_source = info and info.source or ""
local current_dir = script_source:match("@?(.*)/[^/]+") or hypr_dir

-- Ensure current config directory and ~/.config/hypr are in Lua package.path
package.path = current_dir .. "/?.lua;" .. current_dir .. "/?/init.lua;" .. hypr_dir .. "/?.lua;" .. hypr_dir .. "/?/init.lua;" .. package.path

-- Load configuration modules
require("confs.env")
require("confs.monitor")
require("confs.settings")
require("confs.decoration")
require("confs.animations")
require("confs.windowrules")
require("confs.keybinds")
require("confs.startup")
