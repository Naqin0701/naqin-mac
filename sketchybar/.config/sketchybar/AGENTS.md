# AGENTS.md - Agentic Coding Guidelines for sketchybar Config

This repository contains a sketchybar configuration written in Lua using the sbarlua library.

## 项目结构

```
~/.config/sketchybar/
├── sketchybarrc   # Shell 入口脚本
├── init.lua       # 主配置入口，按顺序 require 所有模块
├── colors.lua     # One Dark 配色方案
├── icons.lua      # SF Symbols / Nerd Font 图标常量
├── bar.lua        # Bar 整体外观（高度、位置、背景色）
├── default.lua    # 所有 item 的默认属性
└── items/
    ├── spaces.lua  # Yabai 工作区
    ├── clock.lua   # 时钟 widget
    ├── date.lua    # 日期 widget
    └── apps.lua    # App 快捷方式
```

## 依赖

- [sketchybar](https://github.com/FelixKratz/sketchybar)
- [yabai](https://github.com/koekeishiya/yabai) - 窗口管理
- [sbarlua](https://github.com/FelixKratz/sbarlua) - Lua 绑定库

## 常用命令

```bash
# 验证 Lua 语法
luac -p ~/.config/sketchybar/init.lua
for f in ~/.config/sketchybar/*.lua ~/.config/sketchybar/items/*.lua; do
  luac -p "$f" && echo "OK: $f"
done

# 重载配置（热重载，无需重启）
sketchybar --reload

# 重启服务
brew services restart sketchybar

# 检查状态
sketchybar --ping
```

## 代码风格

### 基本原则
- 缩进：2 空格（不用 Tab）
- 字符串：双引号 `"string"`
- 操作符前后加空格：`a + b`
- 多行 table 尾部加逗号：`{ a = 1, b = 2, }`

### 引入模块
```lua
-- 始终使用 local require
local colors = require("colors")
local sbar = require("sketchybar")

-- 嵌套模块
local module = require("items.spaces")
```

### 命名规范
| 类型 | 规范 | 示例 |
|------|------|------|
| 文件 | snake_case.lua | `clock.lua` |
| 变量 | snake_case | `local num_spaces = 9` |
| 常量 | SCREAMING_SNAKE_CASE | `local NUM_SPACES = 9` |
| Item 名称 | dot.separated | `"apps.finder"`, `"widgets.clock"` |

### 注释规范
- 用户面向配置用中文注释
- 代码逻辑用英文注释

## sbarlua 核心 API

### Item 创建
```lua
-- type: "item" | "space" | "graph"
-- name: 唯一名称，dot.separated
-- position: "left" | "right"
local item = sbar.add("item", "unique.name", "right", {
  icon = {
    string = "●",           -- 图标内容
    font = {
      family = "SF Pro",    -- 字体
      style  = "Regular",   -- 样式
      size   = 14,          -- 字号
    },
    color   = colors.fg,    -- 颜色
    padding_left  = 6,
    padding_right = 4,
    drawing = true,         -- 是否显示
  },
  label = {
    string = "text",
    font   = { ... },
    color  = colors.fg,
    drawing = true,
  },
  background = {
    color         = colors.bg,
    corner_radius = 6,
    height        = 26,
    border_color  = colors.transparent,
    border_width  = 0,
  },
  padding_left  = 2,
  padding_right = 2,
  click_script  = "open -a 'Finder'",  -- 点击执行的 shell 命令
  update_freq   = 10,                  -- 更新频率（秒）
})
```

### Item 更新
```lua
-- 设置属性
item:set({
  icon = { string = "new_icon" },
  background = { color = colors.bg_dim },
})

-- 定时更新（配合 update_freq）
item:subscribe("update", function(_)
  item:set({ label = { string = os.date("%H:%M") } })
end)
```

### 事件订阅
```lua
-- 鼠标悬停
item:subscribe("mouse.entered", function(_)
  item:set({ background = { color = colors.bg_subtle } })
end)

item:subscribe("mouse.exited", function(_)
  item:set({ background = { color = colors.transparent } })
end)

-- 点击事件
item:subscribe("mouse.clicked", function(_)
  sbar.exec("open -a 'Calendar'")
end)

-- Space 切换（仅 space type）
space:subscribe("space_change", function(env)
  local is_active = (tonumber(env.INFO.space) == i)
  space:set({
    icon = { color = is_active and colors.blue or colors.fg_dim },
  })
end)

-- 初始化时强制刷新
space:subscribe("forced", function(_)
  -- 初始化逻辑
end)
```

### 执行 Shell 命令
```lua
sbar.exec("yabai -m query --spaces --space", function(output)
  if output and output ~= "" then
    -- 处理输出
  end
end)
```

## 配色方案（One Dark）

colors.lua 中定义：

```lua
-- 背景
bar_bg     = 0xee21252b,  -- bar 背景（带透明度）
bg         = 0xff282c34,  -- 标准背景
bg_dim     = 0xff2c313a,  -- hover/active 背景
bg_subtle  = 0xff353b45,  -- 选中背景

-- 文字
fg         = 0xffabb2bf,  -- 主文字
fg_dim     = 0xff5c6370,  -- 淡文字

-- 强调色
blue   = 0xff61afef,
green  = 0xff98c379,
yellow = 0xffe5c07b,
orange = 0xffd19a66,
red    = 0xffe06c75,
purple = 0xffc678dd,
cyan   = 0xff56b6c2,

-- 特殊
transparent = 0x00000000,
white       = 0xffeeeeee,
```

**注意**：颜色格式为 `0xAARRGGBB`（Alpha + RGB）或 `0xRRGGBB`。

## 图标

图标定义在 icons.lua，支持：
- SF Symbols（需要安装 SF Pro 字体）
- Nerd Font 字符
- Emoji

```lua
local icons = {
  apps = {
    safari   = "safari",
    terminal = "terminal",
    finder   = "folder",
  },
  space = {
    active   = "●",
    inactive = "○",
  },
  clock    = "⏰",
  calendar = "📅",
}
```

## 配置顺序

### init.lua 中的 require 顺序

```lua
-- 全局外观（先生效）
require("bar")      -- bar 基础属性
require("default")  -- item 默认属性

-- 左侧
require("items.spaces")

-- 右侧（从右往左排列，所以倒序写）
require("items.clock")   -- 最右
require("items.date")    -- clock 左侧
require("items.apps")    -- date 左侧

sbar.hotload(true)  -- 开启热重载
```

## 常见模式

### 工作区高亮
```lua
space:subscribe("space_change", function(env)
  local is_active = (tonumber(env.INFO.space) == i)
  space:set({
    icon = {
      color = is_active and colors.blue or colors.fg_dim,
    },
    background = {
      color = is_active and colors.bg_dim or colors.transparent,
    },
  })
end)
```

### Hover 效果
```lua
item:subscribe("mouse.entered", function(_)
  item:set({ background = { color = colors.bg_subtle } })
end)

item:subscribe("mouse.exited", function(_)
  item:set({ background = { color = colors.transparent } })
end)
```

### 动态时间更新
```lua
local clock = sbar.add("item", "widgets.clock", {
  update_freq = 10,  -- 每 10 秒更新
  -- ...
})

clock:subscribe("update", function(_)
  clock:set({
    label = { string = os.date("%H:%M") },
  })
end)
```

### 遍历生成多个 Item（倒序）
```lua
-- right 区域从右往左排列
for i = #app_list, 1, -1 do
  local entry = app_list[i]
  local item = sbar.add("item", entry.name, {
    position = "right",
    -- ...
  })
end
```

## 添加新 Item 步骤

1. 在 `items/` 创建新文件（如 `items/weather.lua`）
2. 在 `init.lua` 中添加 `require("items.weather")`，注意顺序
3. 参考现有 items 的模式编写
4. 运行 `sketchybar --reload` 测试

## 字体配置

SF Pro 是 macOS 内置字体，推荐使用：
```lua
icon = {
  font = {
    family = "SF Pro",      -- 或 "SF Symbols"
    style  = "Regular",     -- Regular / Bold / Semibold
    size   = 14,
  },
}
```
