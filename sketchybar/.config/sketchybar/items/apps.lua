local colors = require("colors")

-- 常用软件快捷方式
-- 修改此列表来定制你的 App 快捷方式
-- icon: SF Symbols 名称，或直接用 emoji/文字
-- app:  应用名称（open -a 使用的名称）
-- color: 图标颜色（可选，不填则用默认色）
local app_list = {
  {
    name  = "apps.finder",
    icon  = "folder.fill",
    app   = "Finder",
    color = colors.yellow,
  },
  {
    name  = "apps.safari",
    icon  = "safari.fill",
    app   = "Safari",
    color = colors.blue,
  },
  {
    name  = "apps.terminal",
    icon  = "terminal.fill",
    app   = "Terminal",
    color = colors.green,
  },
  -- 按需添加更多 App，例如：
  -- {
  --   name  = "apps.vscode",
  --   icon  = "chevron.left.forwardslash.chevron.right",
  --   app   = "Visual Studio Code",
  --   color = colors.blue,
  -- },
  -- {
  --   name  = "apps.music",
  --   icon  = "music.note",
  --   app   = "Music",
  --   color = colors.red,
  -- },
}

-- 分隔线（app 区域与时钟之间）
sbar.add("item", "apps.separator", "right", {
  icon = {
    string        = "|",
    color         = colors.fg_dim,
    padding_left  = 6,
    padding_right = 6,
  },
  label = { drawing = false },
  background = { color = colors.transparent },
})

-- 生成 App 快捷方式（倒序，因为 right 从右往左排）
for i = #app_list, 1, -1 do
  local entry = app_list[i]
  local item = sbar.add("item", entry.name, "right", {
    icon = {
      string = entry.icon,
      font = {
        family = "SF Symbols",
        style  = "Regular",
        size   = 14,
      },
      color         = entry.color or colors.fg,
      padding_left  = 8,
      padding_right = 8,
    },
    label = { drawing = false },
    background = {
      color         = colors.transparent,
      corner_radius = 6,
      height        = 26,
    },
    padding_left  = 2,
    padding_right = 2,
    click_script  = "open -a '" .. entry.app .. "'",
  })

  -- Hover 效果
  item:subscribe("mouse.entered", function(_)
    item:set({ background = { color = colors.bg_subtle } })
  end)

  item:subscribe("mouse.exited", function(_)
    item:set({ background = { color = colors.transparent } })
  end)
end
