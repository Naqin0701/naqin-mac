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
