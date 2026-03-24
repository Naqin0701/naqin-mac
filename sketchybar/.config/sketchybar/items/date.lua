local colors = require("colors")

local date = sbar.add("item", "widgets.date", "right", {
  update_freq = 60,  -- 每分钟更新
  icon = {
    drawing = false,
  },
  label = {
    string = "%m/%d %a",  -- 格式：03/24 Mon
    font = {
      family = "SF Pro",
      style  = "Regular",
      size   = 13,
    },
    color = colors.fg_dim,
  },
  background = {
    color         = colors.transparent,
    corner_radius = 6,
    height        = 26,
  },
  padding_left  = 4,
  padding_right = 4,
})

-- 每次刷新时更新日期
date:subscribe("update", function(_)
  date:set({
    label = {
      string = os.date("%m/%d %a"),
    },
  })
end)
