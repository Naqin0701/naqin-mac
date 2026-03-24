# 我的 Sketchybar 配置

简洁稳定的 sketchybar 配置，使用 sbarlua（Lua 脚本）+ One Dark 配色。

## 效果

```
[ 1  2  3  4 ... ]          [ finder  safari  terminal  |  03/24 Mon  14:30 ]
```

- **左侧**：Yabai 工作区，数字显示，当前活跃高亮为蓝色
- **右侧**：常用 App 图标 → 日期 → 时钟

---

## 依赖

| 工具 | 说明 | 安装 |
|------|------|------|
| [sketchybar](https://github.com/FelixKratz/SketchyBar) | Bar 本体 | `brew install FelixKratz/formulae/sketchybar` |
| [sbarlua](https://github.com/FelixKratz/sbarlua) | Lua 运行时 | 见下方 |
| [yabai](https://github.com/koekeishiya/yabai) | 窗口管理器 | `brew install koekeishiya/formulae/yabai` |
| SF Pro 字体 | Apple 系统字体 | 通常已内置，或从 Apple 官网下载 |

### 安装 sbarlua

```bash
# 方式 1：从 release 下载二进制
curl -L https://github.com/FelixKratz/sbarlua/releases/latest/download/sbarlua \
  -o ~/.local/bin/sbarlua
chmod +x ~/.local/bin/sbarlua

# 方式 2：从源码编译（需要 swift）
git clone https://github.com/FelixKratz/sbarlua
cd sbarlua && make && cp .build/release/sbarlua ~/.local/bin/
```

---

## 安装配置

```bash
# 1. 备份已有配置（如果有）
mv ~/.config/sketchybar ~/.config/sketchybar.bak

# 2. 复制本配置
cp -r /path/to/this/folder ~/.config/sketchybar

# 3. 赋予执行权限
chmod +x ~/.config/sketchybar/sketchybarrc

# 4. 重启 sketchybar
brew services restart sketchybar
```

---

## 文件结构

```
~/.config/sketchybar/
├── sketchybarrc        # 入口脚本（shell）
├── init.lua            # 主配置（lua 入口）
├── colors.lua          # One Dark 配色
├── icons.lua           # 图标常量
├── bar.lua             # Bar 外观（高度、背景色）
├── default.lua         # Item 默认属性
└── items/
    ├── spaces.lua      # Yabai 工作区
    ├── clock.lua       # 时钟
    ├── date.lua        # 日期
    └── apps.lua        # App 快捷方式
```

---

## 常用定制

### 修改工作区数量

`items/spaces.lua` 第 4 行：
```lua
local NUM_SPACES = 9  -- 改成你实际的 space 数量
```

### 添加 / 删除 App 快捷方式

`items/apps.lua` 中的 `app_list` 表：
```lua
local app_list = {
  { name = "apps.finder",   icon = "folder.fill",  app = "Finder",   color = colors.yellow },
  { name = "apps.safari",   icon = "safari.fill",  app = "Safari",   color = colors.blue   },
  -- 按此格式添加更多 App
  { name = "apps.wechat",   icon = "message.fill", app = "WeChat",   color = colors.green  },
}
```

### 改为浮动圆角样式

`bar.lua` 中取消注释：
```lua
y_offset      = 8,
margin        = 10,
corner_radius = 10,
blur_radius   = 30,
```

### 更改时钟格式

`items/clock.lua`：
```lua
string = os.date("%I:%M %p"),  -- 12 小时制：02:30 PM
string = os.date("%H:%M:%S"),  -- 带秒
```

---

## 热重载

配置已开启 `sbar.hotload(true)`，修改 lua 文件后：

```bash
sketchybar --reload
# 或
brew services restart sketchybar
```
