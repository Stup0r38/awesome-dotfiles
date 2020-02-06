-- ===================================================================
-- Imports
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi


-- ===================================================================
-- Thumbnail Generation
-- ===================================================================


-- thumbnail directory (must recreate on boot up as it is cleaned on shutdown)
local thumbnail_dir = "/tmp/tag-thumbnails/"
awful.spawn.with_shell("mkdir " .. thumbnail_dir)


-- Capture a thumbnail
local function capture_thumbnail(tag)
    -- delay to allow screen to update before capturing thumbnail
    -- DO ME
    -- capture thumbnail
    awful.spawn.with_shell("scrot -e 'mv $f " .. thumbnail_dir .. tag.name .. ".jpg 2>/dev/null'", false)
end


-- check if thumbnail should be created / updated on client open
client.connect_signal("manage", function(c)
    local t = awful.screen.focused().selected_tag
    -- check if any open clients
    for _ in pairs(t:clients()) do
        capture_thumbnail(t)
        return
    end
end)


-- check if thumbnail should be deleted on client open
client.connect_signal("unmanage", function(c)
    local t = awful.screen.focused().selected_tag
    -- update if any open clients
    for _ in pairs(t:clients()) do
        capture_thumbnail(t)
        return
    end
    -- delete if no open clients
    awful.spawn.with_shell("rm " .. thumbnail_dir .. t.name .. ".jpg")
end)


-- check if thumbnail should be captured on client close
client.connect_signal("unmanage", function(c)
    local t = awful.screen.focused().selected_tag
    -- check if any open clients
    for _ in pairs(t:clients()) do
        return
    end
end)


-- ===================================================================
-- Overlay Creation
-- ===================================================================


screen.connect_signal("request::desktop_decoration", function(s)
    -- Create the box
    local tagSwitcherOverlay = wibox {
        visible = nil,
        ontop = true,
        screen = s,
        type = "normal",
        height = dpi(300),
        width = s.geometry.width,
        bg = beautiful.bg_normal,
        x = 0,
        y = 0,
    }

    -- Put its items in a shaped container
    tagSwitcherOverlay:setup {
        -- Container
        {
            require("widgets.brightness-slider-osd"),
            layout = wibox.layout.align.vertical
        },
        -- The real background color & shape
        bg = beautiful.bg_normal,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 35)
        end,
        widget = wibox.container.background()
    }

    -- DISPLAY SIMILAR TO EXIT SCREEN
    local hideTagSwitcher = gears.timer {
        timeout = 5,
        autostart = true,
        callback  = function()
            tagSwitcherOverlay.visible = false
        end
    }

    function showTagSwitcher()
        tagSwitcherOverlay.visible = true
    end
end)