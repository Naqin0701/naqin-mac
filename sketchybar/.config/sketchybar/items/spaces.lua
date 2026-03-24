local colors = require("colors")

-- 工作区数量（按需调整）
local NUM_SPACES = 9

-- 创建分隔用的左侧 padding
sbar.add("item", "spaces.padding", "left", {
  width = 4,
})

for i = 1, NUM_SPACES do
  local space = sbar.add("space", "space." .. i, "left", {
    space = i,
    icon = {
      string = tostring(i),
      font = {
        family = "SF Pro Rounded",
        style  = "Bold",
        size   = 12,
      },
      color = colors.fg_dim,
      padding_left  = 8,
      padding_right = 8,
    },
    label = {
      drawing = false,  -- 不显示 label，只显示数字 icon
    },
    background = {
      color         = colors.transparent,
      border_color  = colors.transparent,
      border_width  = 0,
      corner_radius = 6,
      height        = 26,
    },
    padding_left  = 1,
    padding_right = 1,
    click_script  = "yabai -m space --focus " .. i,
  })

  -- 订阅 space 切换事件，更新高亮状态
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

  -- 订阅 mouse 事件，实现 hover 效果
  space:subscribe("mouse.entered", function(_)
    space:set({
      background = { color = colors.bg_subtle },
    })
  end)

  space:subscribe("mouse.exited", function(env)
    local is_active = (tonumber(env.INFO and env.INFO.space or 0) == i)
    space:set({
      background = { color = is_active and colors.bg_dim or colors.transparent },
    })
  end)

  -- 初始化时检查当前活跃 space
  space:subscribe("forced", function(_)
    sbar.exec("yabai -m query --spaces --space", function(spaces_json)
      if spaces_json and spaces_json ~= "" then
        -- 解析 JSON 获取当前 space index
        local idx = tonumber(spaces_json:match('"index":(%d+)'))
        if idx then
          local is_active = (idx == i)
          space:set({
            icon = {
              color = is_active and colors.blue or colors.fg_dim,
            },
            background = {
              color = is_active and colors.bg_dim or colors.transparent,
            },
          })
        end
      end
    end)
  end)
end
