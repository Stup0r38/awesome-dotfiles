--       ██████╗ █████╗ ██╗     ███████╗███╗   ██╗██████╗  █████╗ ██████╗
--      ██╔════╝██╔══██╗██║     ██╔════╝████╗  ██║██╔══██╗██╔══██╗██╔══██╗
--      ██║     ███████║██║     █████╗  ██╔██╗ ██║██║  ██║███████║██████╔╝
--      ██║     ██╔══██║██║     ██╔══╝  ██║╚██╗██║██║  ██║██╔══██║██╔══██╗
--      ╚██████╗██║  ██║███████╗███████╗██║ ╚████║██████╔╝██║  ██║██║  ██║
--       ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi


-- ===================================================================
-- Create Widget
-- ===================================================================


-- Clock / Calendar 24h format (add %p and use %l instead of %k to use 12h format)
-- Get Time/Date format using `man strftime`
local clock_widget = wibox.widget.textclock("<span font='" .. beautiful.title_font .."'>  %a %d %b,  %k:%M  </span>", 1)

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
   gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, 25)
end

-- Calendar Widget
local month_calendar = awful.widget.calendar_popup.month({
   start_sunday = false,
   spacing = 10,
   font = beautiful.title_font,
   long_weekdays = true,
   margin = 0, -- 10
   style_month = {border_width = 0, padding = 12, shape = cal_shape, padding = 15},
   style_header = {border_width = 0, bg_color = "#00000000"},
   style_weekday = {border_width = 0, bg_color = "#00000000"},
   style_normal = {border_width = 0, bg_color = "#00000000"},
   style_focus = {border_width = 0, bg_color = "#8AB4F8"},
})

-- Attach calentar to clock_widget
month_calendar:attach(clock_widget, "tr" , { on_pressed = true, on_hover = false })

return clock_widget
