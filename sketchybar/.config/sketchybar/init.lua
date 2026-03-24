#!/usr/bin/env lua

-- Load SbarLua
package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.local/share/sketchybar_lua/?.so"
local sbar = require("sketchybar")
local CONFIG_DIR = os.getenv("CONFIG_DIR")

-------------------------------------------------------
-- Bar底座
-------------------------------------------------------
sbar.bar("main", {
  position = "top",
  height   = 25,
  color    = 0x00000000,
})

-------------------------------------------------------
-- 全局默认样式
-------------------------------------------------------
sbar.default({
  icon = {
    font        = "JetBrainsMono Nerd Font:Regular:15.0",
    color       = 0xffe0def4,
    padding_left  = 4,
    padding_right = 4,
  },
})
sbar.default({
  label = {
    font        = "JetBrainsMono Nerd Font:Regular:12.0",
    color       = 0xffe0def4,
    padding_left  = 4,
    padding_right = 4,
  },
})

-------------------------------------------------------
-- 工作区（左侧，10个spaces）
-------------------------------------------------------
for i = 1, 10 do
  local space_name = "space." .. i

  local space = sbar.add("space", space_name, {
    icon = tostring(i),
    background = {
      color        = 0xff232136,
      corner_radius = 4,
      height       = 22,
      border_width = 1,
    },
    icon = {
      padding_left  = 10,
      padding_right = 10,
    },
    padding_left  = 3,
    padding_right = 3,
  })

  space:set({
    click_script = "yabai -m space --focus " .. i,
  })

  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    local f = io.popen("date '+%H:%M'")
    local time_str = f:read("*a"):gsub("\n", "")
    f:close()
    space:set({
      background = { color = selected and 0x66c4a7e7 or 0xff232136 },
      icon       = { color = selected and 0xff232136 or 0xff6e6a86 },
      label      = time_str,
    })
  end)
end

-------------------------------------------------------
-- App启动器（右侧）
-------------------------------------------------------
local apps = {
  { name = "wechat",  bundle = "WeChat",  icon = "" },
  { name = "obsidian", bundle = "Obsidian", icon = "" },
  { name = "vivaldi", bundle = "Vivaldi", icon = "" },
  { name = "ghostty", bundle = "Ghostty", icon = "" },
}

for _, app in ipairs(apps) do
  sbar.add("item", "app." .. app.name, {
    icon = app.icon,
    background = {
      color        = 0xff232136,
      corner_radius = 4,
      height       = 22,
      border_width = 1,
    },
    icon = {
      drawing       = true,
      padding_left  = 6,
      padding_right = 6,
    },
    padding_left  = 1,
    padding_right = 1,
    click_script  = "open -a '" .. app.bundle .. "'",
  })
end

-------------------------------------------------------
-- 日历（右侧）
-------------------------------------------------------
local calendar = sbar.add("item", "calendar", {
  icon = "",
  background = {
    color        = 0xff232136,
    corner_radius = 4,
    height       = 22,
    border_width = 1,
  },
  icon = {
    padding_left = 6,
  },
  padding_left  = 6,
  padding_right = 6,
  script        = CONFIG_DIR .. "/plugins/calendar.sh",
  update_freq   = 3600,
})

local clock = sbar.add("item", "clock", {
  icon = {
    drawing = false,
  },
  background = {
    color        = 0xff232136,
    corner_radius = 4,
    height       = 22,
    border_width = 1,
  },
  label = {
    color         = 0xffe0def4,
    padding_left  = 6,
    padding_right = 6,
  },
  padding_left  = 6,
  padding_right = 6,
  script        = CONFIG_DIR .. "/plugins/clock.sh",
  update_freq   = 30,
})

-------------------------------------------------------
-- 前台应用显示（右侧）
-------------------------------------------------------
local front_app = sbar.add("item", "front_app", {
  icon = {
    drawing = false,
  },
  label = {
    color         = 0xffe0def4,
    padding_left  = 6,
    padding_right = 6,
  },
  background = {
    color        = 0xff232136,
    corner_radius = 4,
    height       = 22,
    border_width = 1,
  },
  padding_left  = 6,
  padding_right = 6,
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = env.INFO })
end)

-------------------------------------------------------
-- 触发首次执行
-------------------------------------------------------
sbar.update()
