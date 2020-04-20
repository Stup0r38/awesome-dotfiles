--      ████████╗ █████╗  ██████╗ ███████╗
--      ╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝
--         ██║   ███████║██║  ███╗███████╗
--         ██║   ██╔══██║██║   ██║╚════██║
--         ██║   ██║  ██║╚██████╔╝███████║
--         ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local dir = os.getenv('HOME') .. '/.config/awesome/icons/tags/'
local awful = require("awful")
local beautiful = require("beautiful")


-- ===================================================================
-- Define tags
-- ===================================================================


local tags = {
  {
    icon = dir .. 'terminal.svg',
    screen = 1
  },
  {
    icon = dir .. 'browser.svg',
    screen = 1
  },
  {
    icon = dir .. 'design.svg',
    screen = 1
  },
  {
    icon = dir .. 'files.svg',
    screen = 1
  },
  {
    icon = dir .. 'games.svg',
    screen = 1
  },
  {
    icon = dir .. 'media.svg',
    screen = 1
  },
  {
    icon = dir .. 'messenger.svg',
    screen = 1
  },
  {
    icon = dir .. 'flag.svg',
    screen = 1
  },
  {
    icon = dir .. 'work.svg',
    screen = 1
  }
}


-- ===================================================================
-- Additional Setup
-- ===================================================================


-- define tag layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

-- apply tag settings to each tag
screen.connect_signal("request::desktop_decoration", function(s)
  for i, tag in pairs(tags) do
    awful.tag.add(i, {
      icon = tag.icon,
      icon_only = true,
      layout = awful.layout.suit.tile,
      screen = s,
      selected = i == 1
    })
  end
end)

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
  local currentLayout = awful.tag.getproperty(t, 'layout')
  if (currentLayout == awful.layout.suit.max) then
    t.gap = 0
  else
    t.gap = beautiful.useless_gap
  end
end)
