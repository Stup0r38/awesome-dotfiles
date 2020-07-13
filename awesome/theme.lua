--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi

local theme = {}


-- ===================================================================
-- Theme Variables
-- ===================================================================


-- Font
theme.font          = "SF Pro Text 10.2"
theme.title_font    = "SF Pro Display Medium 11"

-- Background
theme.bg_normal     = "#283039"
theme.bg_dark       = "#000000"
theme.bg_focus      = "#111111"
theme.bg_urgent     = "#ed8274"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

-- Foreground
theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#e4e4e4"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

-- Sizing
theme.useless_gap         = dpi(6)            -- window gap distance
theme.gap_single_client   = false             -- gaps if only one window is open

-- Window Borders
theme.border_width          = dpi(2)            -- window border width
theme.border_normal         = theme.bg_normal
theme.border_focus          = "#d7cfc6"
theme.border_marked         = theme.fg_urgent

-- Titlebars
theme.titlebar_font = theme.title_font
theme.titlebar_bg = theme.bg_normal
theme.titlebar_bg_focus = theme.titlebar_bg -- make titlebars not change color when focused

-- Taglist
theme.taglist_bg_empty = "#28303990"
theme.taglist_bg_occupied = '#808080cc'
theme.taglist_bg_urgent = '#e91e6399'
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_shape = gears.shape.rounded_bar

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = "#28303990"
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_bg_urgent = theme.bg_urgent
theme.tasklist_bg_minimize = "#808080cc"

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_shape = gears.shape.rounded_bar


-- Notification Sizing
theme.notification_max_width = dpi(350)


--panel sizing
theme.top_panel_height = dpi(28)

--added border for active window
client.connect_signal("focus", function(c) c.border_color = theme.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)


-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/view-float.png"
theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"

theme.icon_theme = "Tela-blue"

-- return theme
return theme
