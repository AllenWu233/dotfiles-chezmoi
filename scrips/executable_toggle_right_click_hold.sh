#!/bin/bash
# Toggle Right Click Hold

STATE_FILE="/tmp/right_click_state"

# 检查状态文件是否存在
if [ -f "$STATE_FILE" ]; then
    xdotool mouseup 3
    notify-send "Right Click Hold Off"
    rm "$STATE_FILE"
else
    xdotool mousedown 3
    notify-send "Right Click Hold On"
    touch "$STATE_FILE"

    # 持续按下右键，直到状态文件被删除
    while [ -f "$STATE_FILE" ]; do
        sleep 0.1
    done
fi
