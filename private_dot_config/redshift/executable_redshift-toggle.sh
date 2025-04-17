#!/usr/bin/env bash

# 获取脚本参数 (status 或 toggle)
ACTION=$1

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
    if pgrep -x "redshift" >/dev/null; then
        pkill -x redshift
    else
        redshift &>/dev/null &
    fi
    ;;
*)
    echo "Usage: $0 {status|toggle}"
    exit 1
    ;;
esac
