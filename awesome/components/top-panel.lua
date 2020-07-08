--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

-- import widgets
local task_list = require("widgets.task-list")
local tag_list = require('widgets.tag-list')
local vseparator = require("widgets.vertical-separator")

-- define module table
local top_panel = {}


--provo a creare un separatore
wibox.widget {
    separator = wibox.widget.separator
}

wibox.widget {
    color        = '#00000000',
    border_width = 1,
    border_color = beautiful.bg_normal,
    widget       = wibox.widget.separator,
}


-- ===================================================================
-- Bar Creation
-- ===================================================================


top_panel.create = function(s)
   local panel = awful.wibar({
--      bg = "000000",
      screen = s,
      position = "top",
      height = beautiful.top_panel_height,
      width = s.geometry.width,
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      {
         layout = wibox.layout.fixed.horizontal,
         tag_list.create(s),
         vseparator,
         task_list.create(s),
      },
         separator,
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),
         require('widgets.battery'),
         require("widgets.layout-box"),
         vseparator,
         require("widgets.calendar")
      }
   }

end

return top_panel
