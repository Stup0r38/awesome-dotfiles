-- ===================================================================
-- Initialization
-- ===================================================================


local wibox = require("wibox")
local dpi = require('beautiful').xresources.apply_dpi

-- ===================================================================
-- Widget Creation
-- ===================================================================


local vertical_separator =  wibox.widget {
   orientation = 'vertical',
   forced_width = dpi(7),
   opacity = 0.00,
   widget = wibox.widget.separator
}

return vertical_separator
