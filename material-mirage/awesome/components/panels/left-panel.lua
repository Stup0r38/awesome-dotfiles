--      ██╗     ███████╗███████╗████████╗    ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ██║     ██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--      ██║     █████╗  █████╗     ██║       ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--      ██║     ██╔══╝  ██╔══╝     ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--      ███████╗███████╗██║        ██║       ██║     ██║  ██║██║ ╚████║███████╗███████╗
--      ╚══════╝╚══════╝╚═╝        ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = beautiful.xresources.apply_dpi
local awful = require('awful')
local gears = require('gears')


-- ===================================================================
-- Bar Creation
-- ===================================================================


local LeftPanel = function(s)
  local left_panel = awful.wibar({
    ontop = true,
    position = "left",
    screen = s,
    bg = beautiful.panel_color,
    fg = beautiful.fg_normal,
    width = beautiful.left_panel_width,
    height = s.geometry.height,
    shape = function(cr, width, height)
      gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 35)
    end
  })

  left_panel:setup {
    expand = "none",
    layout = wibox.layout.align.vertical,
    require("widgets.layout-box"),
    {
      layout = wibox.layout.fixed.vertical,
      -- add dock widget
      require("widgets.dock")
    },
    nil
  }

  function maximizeLeftPanel(bool)
    if bool then
      left_panel.shape = function(cr, width, height)
        gears.shape.rectangle(cr, width, height)
      end
    else
      left_panel.shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 35)
      end
    end
  end
end

return LeftPanel