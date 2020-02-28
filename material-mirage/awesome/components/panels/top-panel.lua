--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('icons')

-- import widgets
local mat_icon_button = require('widgets.icon-button')
local mat_icon = require('widgets.icon')


-- ===================================================================
-- Bar Widget Creation
-- ===================================================================


-- Create to each screen
screen.connect_signal("request::desktop_decoration", function(s)
  s.systray = wibox.widget.systray()
  s.systray.visible = false
  s.systray:set_horizontal(true)
  s.systray:set_base_size(28)
  s.systray.opacity = 0.3
  beautiful.systray_icon_spacing = 16
end)

-- Execute only if system tray widget is not loaded
awesome.connect_signal("toggle_tray", function()
  if not require('widgets.systemtray') then
    if awful.screen.focused().systray.v then
    -- open tag application button
    local add_button = mat_icon_button(mat_icon(icons.open, dpi(10)))
    add_button:buttons(
      gears.table.join(
        awful.button({}, 1, nil,
          function()
            awful.spawn(
              awful.screen.focused().selected_tag.defaultApp,
              {
                tag = mouse.screen.selected_tag,
                placement = awful.placement.bottom_right
              }
            )
          end
        )
      )
    )
    sible = false
    end
  end
end)


-- ===================================================================
-- Bar Creation
-- ===================================================================


local TopPanel = function(s)
  local panel = wibox {
    ontop = false,
    type = "dock",
    screen = s,
    height = beautiful.top_panel_height,
    width = s.geometry.width,
    x = s.geometry.x,
    y = s.geometry.y,
    stretch = false,
    bg = "#00000000",
    fg = beautiful.fg_normal
  }

  panel:setup {
    expand = "none",
    layout = wibox.layout.align.horizontal,
    nil,
	  require("widgets.time-calendar"),
    {
      layout = wibox.layout.fixed.horizontal,
      s.systray,
      require('widgets.systemtray'),
      require('widgets.package-updater'),
      require('widgets.bluetooth'),
      require('widgets.wifi'),
      require('widgets.battery'),
    }
  }

  function maximizeTopPanel(bool)
    if bool then
      panel.bg = beautiful.panel_color
    else
      panel.bg = "#00000000"
    end
  end

  return panel
end

return TopPanel
