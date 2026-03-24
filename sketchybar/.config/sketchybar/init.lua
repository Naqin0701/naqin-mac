-- sketchybar 配置入口
-- 使用 sbarlua (https://github.com/FelixKratz/sbarlua)
-- 依赖：sketchybar, yabai, sbarlua

-- 添加配置目录到 require 路径
package.cpath = package.cpath .. ";/Users/" .. os.getenv("USER") .. "/.local/share/sketchybar_lua/?.so"
-- ── 全局外观 ─────────────────────────────────────────────
require("bar")      -- bar 基础属性（高度、颜色等）
require("default")  -- item 默认属性

-- ── 左侧：工作区 ─────────────────────────────────────────
require("items.spaces")

-- ── 右侧：App / 日期 / 时钟 ──────────────────────────────
-- 注意：right 区域 item 是从右往左排列的
-- 所以 require 顺序：最右的先写

require("items.clock")   -- 最右：时钟
require("items.date")    -- 时钟左侧：日期
require("items.apps")    -- 日期左侧：App 快捷方式

-- ── 结束初始化 ───────────────────────────────────────────
sbar.hotload(true)   -- 开启热重载（改文件自动生效）
