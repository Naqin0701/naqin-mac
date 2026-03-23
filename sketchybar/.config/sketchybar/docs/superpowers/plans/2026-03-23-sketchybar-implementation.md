# SketchyBar 个性化配置实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**目标：** 将 sketchybar 从基础 demo 配置重设计为 Rose Pine 主题 + 悬浮卡片式极简状态栏

**架构：** 重写 `sketchybarrc` 主配置，应用 Rose Pine 配色和悬浮卡片布局；更新/新建插件脚本支持各模块功能

**技术栈：** sketchybar 配置语法 / shell 脚本 / yabai 集成

---

## 文件结构

```
sketchybarrc               # 重写：主配置，应用 Rose Pine + 悬浮卡片
plugins/
├── space.sh          # 工作区背景切换
├── clock.sh          # 时钟刷新
├── calendar.sh       # 日历日期（新建）
└── front_app.sh      # 当前聚焦应用（备用，可删除）
```

---

## 任务列表

### 任务 1：重写 sketchybarrc 主配置

**文件：**
- 修改: `sketchybarrc`

- [ ] **Step 1: 写入新的 sketchybarrc**

```bash
PLUGIN_DIR="$CONFIG_DIR/plugins"

##### Bar 底座 #####
sketchybar --bar position=top height=25 color=0x00000000

##### 全局默认样式 #####
default=(
  icon.font="JetBrains Mono Nerd Font:Regular:15.0"
  label.font="Hack Nerd Font:Regular:12.0"
  icon.color=0xffe0def4
  label.color=0xffe0def4
  icon.padding_left=4
  icon.padding_right=4
  label.padding_left=4
  label.padding_right=4
)
sketchybar --default "${default[@]}"

##### 工作区组（左侧）#####
SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
for i in "${!SPACE_ICONS[@]}"; do
  sid="$(($i+1))"
  sketchybar --add group space."$sid" left
  space_item=(
    space="$sid"
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=6
    icon.padding_right=6
    background.color=0xff232136
    background.corner_radius=4
    background.height=22
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
    click_script="yabai -m space --focus $sid"
  )
  sketchybar --add item space."$sid" left \
    --set space."$sid" "${space_item[@]}"
done

##### 常用 App 组（右侧）#####
APPS=("WeChat:WeChat" "Obsidian:Obsidian" "Vivaldi:Vivaldi" "Ghostty:Ghostty")
for app_info in "${APPS[@]}"; do
  app_name="${app_info%%:*}"
  app_bundle="${app_info##*:}"
  sketchybar --add item "$app_name" right \
    --set "$app_name" \
      icon.drawing=on \
      background.color=0xff232136 \
      background.corner_radius=4 \
      background.height=22 \
      padding_left=6 \
      padding_right=6 \
      script="$PLUGIN_DIR/space.sh" \
      click_script="open -a '$app_bundle'"
done

##### 日历（右侧）#####
sketchybar --add item calendar right \
  --set calendar \
    icon=cal \
    label.drawing=off \
    background.color=0xff232136 \
    background.corner_radius=4 \
    background.height=22 \
    padding_left=6 \
    padding_right=6 \
    script="$PLUGIN_DIR/calendar.sh" \
    click_script="open -a Calendar"

##### 时钟（右侧）#####
sketchybar --add item clock right \
  --set clock \
    icon.drawing=off \
    label.color=0xffe0def4 \
    background.color=0xff232136 \
    background.corner_radius=4 \
    background.height=22 \
    padding_left=6 \
    padding_right=6 \
    update_freq=30 \
    script="$PLUGIN_DIR/clock.sh"

##### 强制首次运行所有脚本 #####
sketchybar --update
```

- [ ] **Step 2: 提交**

```bash
git add sketchybarrc && git commit -m "feat: Rewrite sketchybarrc with Rose Pine + floating card layout"
```

---

### 任务 2：更新 space.sh（工作区脚本）

**文件：**
- 修改: `plugins/space.sh`

- [ ] **Step 1: 更新 space.sh**

```sh
#!/bin/sh

# Rose Pine 配色工作区脚本
# $SELECTED: 是否为当前选中 space
# $NAME:    当前 space 的名称

CARD_BG_SELECTED="0x66c4a7e7"  # 选中：40% 不透明紫罗兰
CARD_BG_INACTIVE="0xff232136"   # 未选中：卡片背景
ICON_COLOR_SELECTED="0xffe0def4"  # 选中：主文字色
ICON_COLOR_INACTIVE="0xff6e6a86"  # 未选中：淡化文字色

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" \
    background.color="$CARD_BG_SELECTED" \
    icon.color="$ICON_COLOR_SELECTED"
else
  sketchybar --set "$NAME" \
    background.color="$CARD_BG_INACTIVE" \
    icon.color="$ICON_COLOR_INACTIVE"
fi
```

- [ ] **Step 2: 提交**

```bash
git add plugins/space.sh && git commit -m "feat(space): Apply Rose Pine colors with floating card effect"
```

---

### 任务 3：更新 clock.sh（时钟脚本）

**文件：**
- 修改: `plugins/clock.sh`

- [ ] **Step 1: 更新 clock.sh**

```sh
#!/bin/sh

sketchybar --set "$NAME" label="$(date '+%H:%M')"
```

- [ ] **Step 2: 提交**

```bash
git add plugins/clock.sh && git commit -m "fix(clock): Update to 24h format %H:%M"
```

---

### 任务 4：新建 calendar.sh（日历脚本）

**文件：**
- 新建: `plugins/calendar.sh`

- [ ] **Step 1: 写入 calendar.sh**

```sh
#!/bin/sh

# 显示格式: "23 Mar"（日 + 缩写月，首字母大写）
sketchybar --set "$NAME" label="$(date '+%d %b')"
```

- [ ] **Step 2: 提交**

```bash
git add plugins/calendar.sh && git commit -m "feat(calendar): Add calendar date display plugin"
```

---

### 任务 5：添加 App 图标显示

**文件：**
- 修改: `sketchybarrc`

> **说明：** 上方的 sketchybarrc 中 App 项使用了 `icon.drawing=on` 但未设置图标内容。
> 需要通过 sketchybar 的 alias 或 icon 属性为每个 App 设置对应的 Nerd Font / SF Symbol 图标。

- [ ] **Step 1: 查找 App 图标对应的 Nerd Font / SF Symbol**

常见图标映射：
| App | 推荐图标 |
|-----|---------|
| WeChat | `󰟢` (Nerd Font) 或 `W` (缩写) |
| Obsidian | `󱚟` (Nerd Font) 或 `Ob` |
| Vivaldi | `󰖁` 或 `Vi` |
| Ghostty | `󰽙` 或 `Gt` |

> 如 Nerd Font 无合适图标，可用单字母缩写（如 `W`、`Ob`、`Vi`、`Gt`）

- [ ] **Step 2: 在 sketchybarrc 的 App 循环中添加 icon 属性**

修改 App 循环部分，为每个 app 添加 `icon="..."` 参数：

```bash
ICON_MAP=("WeChat:󰟢" "Obsidian:󱚟" "Vivaldi:󰖁" "Ghostty:󰽙")
```

- [ ] **Step 3: 提交**

```bash
git add sketchybarrc && git commit -m "feat: Add app icons to launcher items"
```

---

## 验证步骤

完成所有任务后，运行以下命令测试：

```bash
# 重载 sketchybar 配置
brew services restart sketchybar
# 或
sketchybar --reload
```

检查项：
- [ ] 状态栏高度是否为 25px
- [ ] 状态栏底座是否完全透明
- [ ] 工作区 1-10 是否显示为独立卡片，选中时背景变紫罗兰色
- [ ] 日历是否显示 `23 Mar` 格式
- [ ] 时钟是否显示 `14:30` 格式
- [ ] 点击 App 图标是否正确启动对应应用
- [ ] 整体视觉是否符合 Rose Pine 配色
