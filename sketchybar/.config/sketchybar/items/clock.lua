local colors = require("colors")
local sbar = require("sketchybar")

local clock = sbar.add("item", "widgets.clock", {
  position = "right",
  update_freq = 10,  -- 每 10 秒更新
  icon = {
    drawing = false,
  },
  label = {
    string = os.date("%H:%M"),
    font = {
      family = "SF Pro",
      style  = "Semibold",
      size   = 13,
    },
    color = colors.fg,
  },
  background = {
    color        = colors.bg_dim,
    corner_radius = 6,
    height       = 26,
  },
  padding_left  = 4,
  padding_right = 4,
})

-- 初始化时设置时间
clock:subscribe("forced", function(_)
  clock:set({
    label = {
      string = os.date("%H:%M"),
    },
  })
end)

-- 每次刷新时更新时钟
clock:subscribe("update", function(_)
  clock:set({
    label = {
      string = os.date("%H:%M"),
    },
  })
end)

-- 点击时钟可以打开日历应用（可选）
clock:subscribe("mouse.clicked", function(_)
  sbar.exec("open -a 'Calendar'")
end)
