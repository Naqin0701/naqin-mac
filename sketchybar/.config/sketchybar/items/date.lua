local colors = require("colors")
local sbar = require("sketchybar")

local date = sbar.add("item", "widgets.date", {
  position = "right",
  update_freq = 60,
  icon = {
    string = os.date("%m/%d"),
    font = {
      family = "SF Pro",
      style  = "Regular",
      size   = 13,
    },
    color = colors.fg,
  },
  label = {
    drawing = false,
  },
  background = {
    color         = colors.bg_dim,
    corner_radius = 6,
    height        = 26,
  },
  padding_left  = 4,
  padding_right = 4,
})

date:subscribe("update", function(_)
  date:set({
    icon = {
      string = os.date("%m/%d"),
    },
  })
end)
