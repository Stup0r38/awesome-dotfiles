local awful = require('awful')
local naughty = require('naughty')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widgets.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

local apps = require('apps')

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/icons/dock/'

local homeWidget =
  wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

local home_button = clickable_container(wibox.container.margin(homeWidget, dpi(8), dpi(8), dpi(8), dpi(8)))
home_button:buttons(
  gears.table.join(
    awful.button({}, 1, nil,
      function()
        awful.spawn(apps.terminal)
      end
    )
  )
)

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
  {
    objects = {home_button},
    mode = 'outside',
    align = 'right',
    timer_function = function()
      return 'Terminal'
    end,
    preferred_positions = {'right', 'left', 'top', 'bottom'}
  }
)

homeWidget.icon:set_image(PATH_TO_ICONS .. 'terminal.svg')

return home_button
