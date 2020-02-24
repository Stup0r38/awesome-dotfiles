-- ===================================================================
-- Imports
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi


-- ===================================================================
-- Thumbnail Image Generation
-- ===================================================================


-- thumbnail directory (must recreate on boot up as it is cleaned on shutdown)
local thumbnail_dir = "/tmp/tag-thumbnails/"
awful.spawn.with_shell("mkdir " .. thumbnail_dir)


-- Capture a thumbnail
local function capture_thumbnail(tag)
    -- capture thumbnail
    awful.spawn.with_shell("sleep 0.3; scrot -e 'mv $f " .. thumbnail_dir .. tag.name .. ".jpg 2>/dev/null'", false)
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
-- Thumbnail Widget Creation
-- ===================================================================


local overlayHeight = dpi(200)
local thumbnailMargin = dpi(50)

local function makeThumbnail(image)
    imagebox = wibox.widget {
        image = thumbnail_dir .. "/" .. image .. ".jpg",
        clip_shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, dpi(10))
        end,
        forced_height = overlayHeight * 0.70,
        widget = wibox.widget.imagebox,
    }
    -- add imagebox:buttons()

    thumbnail = wibox.widget {
        imagebox,
        left = thumbnailMargin,
        right = thumbnailMargin,
        top = overlayHeight * 0.15,
        bottom = overlayHeight * 0.15,
        widget = wibox.container.margin
    }
    return thumbnail
end


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
        height = overlayHeight,
        width = s.geometry.width,
        bg = beautiful.bg_normal,
        shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 40)
        end,
        x = 0,
        y = 0,
    }

    -- Put its items in a shaped container
    tagSwitcherOverlay:setup {
        -- Container
        expand = "none",
        layout = wibox.layout.align.horizontal,
        nil,
        {
            makeThumbnail("1"),
            layout = wibox.layout.align.vertical
        },
        -- The real background color & shape
        bg = beautiful.bg_normal,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 35)
        end,
        widget = wibox.container.background()
    }

    -- Open Tag Switcher on Tag Swap
    tag.connect_signal('property::selected', function(t)
        tagSwitcherOverlay.visible = true
        -- TODO: STAY OPEN IF USER CONTINUES TO SWITCH TAGS
        gears.timer {
            timeout = 2,
            autostart = true,
            callback  = function()
                tagSwitcherOverlay.visible = false
            end
        }
    end)
end)
