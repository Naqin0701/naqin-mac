-- One Dark 配色方案
local colors = {
  -- 背景
  bar_bg     = 0xee21252b,  -- bar 背景（带透明度）
  bg         = 0xff282c34,  -- 标准背景
  bg_dim     = 0xff2c313a,  -- 稍亮背景，用于 hover/active
  bg_subtle  = 0xff353b45,  -- 更亮，用于选中

  -- 文字
  fg         = 0xffabb2bf,  -- 主文字
  fg_dim     = 0xff5c6370,  -- 淡文字 / 分隔线

  -- 强调色
  blue       = 0xff61afef,
  green      = 0xff98c379,
  yellow     = 0xffe5c07b,
  orange     = 0xffd19a66,
  red        = 0xffe06c75,
  purple     = 0xffc678dd,
  cyan       = 0xff56b6c2,

  -- 特殊
  transparent = 0x00000000,
  white       = 0xffeeeeee,
}

return colors
