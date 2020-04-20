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
local dpi = require('beautiful').xresources.apply_dpi
local awful = require('awful')
local gears = require('gears')

local TagList = require('widgets.tag-list')


-- ===================================================================
-- Bar Creation
-- ===================================================================

local LeftPanel = function(s)
    local panel = wibox {
        ontop = false,
        screen = s,
        height = s.geometry.height,
        width = beautiful.left_panel_width,
        x = s.geometry.x,
        y = s.geometry.y,
        stretch = false,
        bg = beautiful.panel_color,
        fg = beautiful.fg_normal,
        shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 35)
        end
    }

    panel:struts({
		left = beautiful.left_panel_width
	})

    -- add widgets to panel
    panel:setup {
        expand = "none",
        layout = wibox.layout.align.vertical,
        require("widgets.layout-box"),
        {
            layout = wibox.layout.fixed.vertical,
            TagList(s)
        },
        nil
    }
  
    function maximizeLeftPanel(bool)
        return
    end

    return panel
end

return LeftPanel
