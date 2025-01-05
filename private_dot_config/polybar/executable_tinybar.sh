#!/usr/bin/env bash
# Script of Tiny-launch polybar
window_name="polybar-traymenu_eDP-1"
u=$(xprop -name ${window_name} _NET_WM_PID | grep -o '[[:digit:]]*')

if [ "$u" ]; then
    kill "$u"
else
    echo "---" | tee -a /tmp/polybar2.log
    polybar traymenu >>/tmp/polybar2.log 2>&1
fi
