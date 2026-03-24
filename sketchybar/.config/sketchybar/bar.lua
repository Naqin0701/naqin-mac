local colors = require("colors")

-- Bar 整体外观设置
sbar.bar({
  height        = 36,
  color         = colors.bar_bg,
  border_width  = 0,
  shadow        = false,
  position      = "top",
  sticky        = true,
  padding_right = 12,
  padding_left  = 12,
  -- 可选：圆角浮动样式
  -- y_offset   = 8,
  -- margin     = 10,
  -- corner_radius = 10,
  -- blur_radius   = 30,
  -- topmost    = "window",
})
