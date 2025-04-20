#!/usr/bin/env bash

# 获取脚本参数 (status 或 toggle 或 auto)
ACTION=$1

# 定义自动切换时间段
START_HOUR=20
END_HOUR=7

CLICK_SOUND="$HOME/.config/i3status-rust/click_stereo.ogg"

# Function to play sound using mpv
play_sound() {
    local sound_file=$1
    if [[ -f $sound_file ]]; then
        mpv --no-terminal --quiet "$sound_file" &
    fi
}

case "$ACTION" in
status)
    # 检查 Redshift 是否运行
    if pgrep -x "redshift" >/dev/null; then
        echo "" # ON
    else
        echo "󰽥" # OFF
    fi
    ;;
toggle)
    # 切换 Redshift 状态
    play_sound "$CLICK_SOUND"
    if pgrep -x "redshift" >/dev/null; then
        pkill -x redshift
        notify-send "Redshift" "Redshift OFF"
    else
        redshift &>/dev/null &
        notify-send "Redshift" "Redshift ON"
    fi
    ;;
auto)
    # 根据时间段自动运行或关闭 Redshift
    CURRENT_HOUR=$(date +"%H")
    if ((CURRENT_HOUR >= START_HOUR || CURRENT_HOUR < END_HOUR)); then
        if ! pgrep -x "redshift" >/dev/null; then
            redshift &>/dev/null &
            notify-send "Redshift" "Redshift 已根据时间段自动开启" # 发送通知
        fi
    else
        if pgrep -x "redshift" >/dev/null; then
            pkill -x redshift
            notify-send "Redshift" "Redshift 已根据时间段自动关闭" # 发送通知
        fi
    fi
    ;;
*)
    echo "Usage: $0 {status|toggle|auto}"
    exit 1
    ;;
esac

##!/usr/bin/env bash
#
## 获取脚本参数 (status 或 toggle 或 auto)
#ACTION=$1
#
## 定义自动切换时间段
#START_HOUR=20
#END_HOUR=7
#
#case "$ACTION" in
#status)
#    # 检查 Redshift 是否运行
#    if pgrep -x "redshift" >/dev/null; then
#        echo "" # ON
#    else
#        echo "󰽥" # OFF
#    fi
#    ;;
#toggle)
#    # 切换 Redshift 状态
#    if pgrep -x "redshift" >/dev/null; then
#        pkill -x redshift
#    else
#        redshift &>/dev/null &
#    fi
#    ;;
#auto)
#    # 根据时间段自动运行或关闭 Redshift
#    CURRENT_HOUR=$(date +"%H")
#    if ((CURRENT_HOUR >= START_HOUR || CURRENT_HOUR < END_HOUR)); then
#        if ! pgrep -x "redshift" >/dev/null; then
#            redshift &>/dev/null &
#        fi
#    else
#        if pgrep -x "redshift" >/dev/null; then
#            pkill -x redshift
#        fi
#    fi
#    ;;
#*)
#    echo "Usage: $0 {status|toggle|auto}"
#    exit 1
#    ;;
#esac
