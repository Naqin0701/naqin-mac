#!/bin/sh

# 显示格式: "23 Mar"（日 + 缩写月，首字母大写）
sketchybar --set "$NAME" label="$(date '+%d/%m %b')"
