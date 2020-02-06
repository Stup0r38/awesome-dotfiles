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
local apps = require("apps")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")


-- ===================================================================
-- Define tags
-- ===================================================================


local tags = {
  {
    icon = dir .. 'terminal.png',
    screen = 1
  },
  {
    icon = dir .. 'firefox.png',
    screen = 1
  },
  {
    icon = dir .. 'notepad.png',
    screen = 1
  },
  {
    icon = dir .. 'folder.png',
    screen = 1
  },
  {
    icon = dir .. 'player.png',
    screen = 1
  },
  {
    icon = dir .. 'videogame.png',
    screen = 1
  },
  {
    icon = dir .. 'star.png',
    screen = 1
  },
  {
    icon = dir .. 'mail.png',
    screen = 1
  },
  {
    icon = dir .. 'spotify.png',
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
