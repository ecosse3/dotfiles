local battery = require("items.widgets.battery")
local volume = require("items.widgets.volume")
local wifi = require("items.widgets.wifi")
local cpu_and_temp = require("items.widgets.cpu_and_temp")
local workspaces = require("items.spaces_aero_dev")
local apple = require("items.apple")
local front_app = require("items.front_app")
local cal = require("items.calendar")
local media = require("items.media")

local colors = require("colors")

-- Right side bracket
sbar.add("bracket", {
  volume.volume_icon.name,
  volume.volume_percent.name,
  cal.cal.name,
}, {
  background = {
    color = colors.bar.bracket,
    height = 30,
    corner_radius = 8,
    border_color = colors.bar.border,
    border_width = 1,
    padding_right = 12,
    padding_left = 8,
  }
})

-- Left side bracket
sbar.add("bracket", {
  apple.apple.name,
  workspaces[1].name,
  workspaces[2].name,
  workspaces[3].name,
  workspaces[4].name,
  workspaces[5].name,
  workspaces[6].name,
  workspaces[7].name,
  workspaces[8].name,
  workspaces[9].name,
  workspaces[10].name,
}, {
  background = {
    color = colors.bar.bracket,
    border_color = colors.bar.border,
    border_width = 1,
    height = 30,
    corner_radius = 8,
    padding_left = 12,
    padding_right = 12,
  },
})
