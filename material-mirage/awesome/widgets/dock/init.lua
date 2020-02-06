local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local separator =  wibox.widget
  {
    orientation = 'horizontal',
    forced_height = dpi(16),
    opacity = 0.20,
    widget = wibox.widget.separator
  }

return wibox.widget {
  layout = wibox.layout.align.vertical,
  {
    require("widgets.dock.browser"),
    require("widgets.dock.terminal"),
    require("widgets.dock.files"),
    require("widgets.dock.games"),
    require("widgets.dock.media"),
    require("widgets.dock.messenger"),
    require("widgets.dock.design"),
    layout = wibox.layout.fixed.vertical
  }
}
