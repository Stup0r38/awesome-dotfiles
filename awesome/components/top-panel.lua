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
local dpi = require("beautiful").xresources.apply_dpi

-- import widgets
local task_list = require("widgets.task-list")
local tag_list = require('widgets.tag-list')
local separator1 = require("widgets.vertical-separator")

-- define module table
local top_panel = {}


-- ===================================================================
-- Bar Widget Creation
-- ===================================================================


-- Clock / Calendar 12h format
-- Get Time/Date format using `man strftime`
local clock_widget = wibox.widget.textclock("<span font='" .. beautiful.title_font .."'>%l:%M %p</span>", 1)

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


-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip({
   objects = {clock_widget},
   mode = "outside",
   align = "right",
   timer_function = function()
      return os.date("%B %d, %Y. %A.")
   end,
   preferred_positions = {"right", "left", "top", "bottom"},
   margin_leftright = dpi(8),
   margin_topbottom = dpi(8)
})

--rotondità degli spigoli del calendario
local cal_shape = function(cr, width, height)
   gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, 12)
end

-- Calendar Widget
local month_calendar = awful.widget.calendar_popup.month({
   start_sunday = false,
   spacing = 10,
   font = beautiful.title_font,
   long_weekdays = true,
   margin = 0, -- 10
   style_month = {border_width = 0, padding = 12, shape = cal_shape, padding = 20},
   style_header = {border_width = 0, bg_color = "#00000000"},
   style_weekday = {border_width = 0, bg_color = "#00000000"},
   style_normal = {border_width = 0, bg_color = "#00000000"},
   style_focus = {border_width = 0, bg_color = "#8AB4F8"},
})

-- Attach calentar to clock_widget
month_calendar:attach(clock_widget, "tr" , { on_pressed = true, on_hover = false })


-- ===================================================================
-- Bar Creation
-- ===================================================================


top_panel.create = function(s)
   local panel = awful.wibar({
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
         separator1,
         task_list.create(s),
      },
         separator,
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), 0, 0, 3, 3),
         require('widgets.battery'),
         require("widgets.layout-box"),
         separator1,
         clock_widget
      }
   }

end

return top_panel
