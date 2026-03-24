local colors = require("colors")
local sbar = require("sketchybar")

-- 所有 item 的默认属性
sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = "SF Pro",
      style  = "Regular",
      size   = 14,
    },
    color   = colors.fg,
    padding_left  = 6,
    padding_right = 4,
  },
  label = {
    font = {
      family = "SF Pro",
      style  = "Regular",
      size   = 13,
    },
    color   = colors.fg,
    padding_left  = 4,
    padding_right = 6,
  },
  background = {
    color        = colors.transparent,
    border_color = colors.transparent,
    border_width = 0,
    corner_radius = 6,
    height       = 26,
  },
  padding_left  = 2,
  padding_right = 2,
})
