--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Import theme
local xresources = require("beautiful.xresources")
local beautiful = require("beautiful")
local dpi = xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- Notification library
require("components.notifications")

-- Import Tag Settings
local tags = require("tags")


-- Import components
require("components.wallpaper")
require("components.exit-screen")
require("components.volume-adjust")

--kill application before startup
awful.spawn.with_shell("killall nm-applet")
awful.spawn.with_shell("killall blueman-applet")

-- Autostart specified apps
local apps = require("apps")
apps.autostart()

-- ===================================================================
-- Set Up Screen & Connect Signals
-- ===================================================================

-- Define tag layouts
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.max,
}


-- Set up each screen
local top_panel = require("components.top-panel")


awful.screen.connect_for_each_screen(function (s)
    for i, tag in pairs(tags) do
        awful.tag.add(i, {
            icon = tag.icon,
            icon_only = true,
            layout = awful.layout.suit.tile,
            screen = s,
            selected = i == 1
        })
    end
    
	-- Add the top panel to the screen
    top_panel.create(s)

    --decrease useless gap size near the borders of the screen
    s.padding = {
        left = dpi(-2),
        right = dpi(-2),
        top = dpi(-1),
        bottom = dpi(-2)
    }
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the window as a slave (put it at the end of others instead of setting it as master)
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

--Remove borders when window is maximized
screen.connect_signal("arrange", function (s)
    local max = s.selected_tag.layout.name == "max"
    local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
    -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
    for _, c in pairs(s.clients) do
        if (max or only_one) and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================


collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

--autostart applications
awful.spawn.with_shell("blueman-applet")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("xfce4-power-manager --restart")
awful.spawn.with_shell("numlockx")
