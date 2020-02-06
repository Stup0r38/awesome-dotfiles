local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local function renderClient(client)
  if client.fullscreen == true then
    client.shape = function(cr, w, h)
      gears.shape.rectangle(cr, w, h)
    end
  else
    client.shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius)
    end
  end
end

local changesOnScreenCalled = false

local function changesOnScreen(currentScreen)
  local tagIsMax = currentScreen.selected_tag ~= nil and currentScreen.selected_tag.layout == awful.layout.suit.max
  local clientsToManage = {}

  for _, client in pairs(currentScreen.clients) do
    if not client.skip_decoration and not client.hidden then
      table.insert(clientsToManage, client)
    end
  end

  if (tagIsMax or #clientsToManage == 1) then
    currentScreen.client_mode = 'maximized'
  else
    currentScreen.client_mode = 'dwindle'
  end

  for _, client in pairs(clientsToManage) do
    renderClient(client)
  end
  changesOnScreenCalled = false
end


function clientCallback(client)
  if not changesOnScreenCalled then
    if not client.skip_decoration and client.screen then
      changesOnScreenCalled = true
      local screen = client.screen
      gears.timer.delayed_call(
        function()
          changesOnScreen(screen)
        end
      )
    end
  end
end

function tagCallback(tag)
  if not changesOnScreenCalled then
    if tag.screen then
      changesOnScreenCalled = true
      local screen = tag.screen
      gears.timer.delayed_call(
        function()
          changesOnScreen(screen)
        end
      )
    end
  end
end

client.connect_signal('manage', clientCallback)

client.connect_signal('unmanage', clientCallback)

client.connect_signal('property::hidden', clientCallback)

client.connect_signal('property::minimized', clientCallback)

client.connect_signal(
  'property::fullscreen',
  function(c)
    if c.fullscreen then
      renderClient(c)
    else
      clientCallback(c)
    end
  end
)

tag.connect_signal('property::selected', tagCallback)

tag.connect_signal('property::layout', tagCallback)