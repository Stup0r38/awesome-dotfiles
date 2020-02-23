local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require('beautiful').xresources.apply_dpi

-- Catch the Signal when a client is created
_G.client.connect_signal("manage", function(c)
  
  -- Center all clients with skip_center property on spawn
  if c.floating and not c.skip_center then
    awful.placement.centered(c)
  end

  -- Hide bars when client and layout is maximized
  if not c.max then
    awful.titlebar.show(c, 'top')
  else
    awful.titlebar.hide(c, 'top')
  end

end)

-- Catch the signal when a client's layout is changed
_G.screen.connect_signal("arrange", function(s)
  for _, c in pairs(s.clients) do
    if (#s.tiled_clients > 1 or c.floating) and c.first_tag.layout.name ~= 'max' then
      if not c.hide_titlebars then
        awful.titlebar.show(c, 'top')
      else 
        awful.titlebar.hide(c, 'top')
      end
    elseif (#s.tiled_clients == 1 or c.first_tag.layout.name == 'max') and not c.fullscreen then
      awful.titlebar.hide(c, 'top')
    end
  end
end)