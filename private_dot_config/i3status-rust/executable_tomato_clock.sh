#!/bin/bash
# Tomato Clock script with start/pause and mode toggle for i3status-rust
# Generate by Copilot

# Set durations (in seconds)
WORK_DURATION=$((25 * 60)) # 25 minutes
BREAK_DURATION=$((5 * 60)) # 5 minutes

# State file to persist timer across restarts
STATE_FILE="/tmp/tomato_clock_state"

# Default state if no state file exists
if [[ ! -f $STATE_FILE ]]; then
    echo "state=not_started" >$STATE_FILE
    echo "mode=work" >>$STATE_FILE
    echo "remaining=$WORK_DURATION" >>$STATE_FILE
    echo "start_time=0" >>$STATE_FILE
fi

# Load state
source $STATE_FILE

# Handle click events
if [[ $1 == "left" ]]; then
    # Left click: Start/Pause the timer
    if [[ $state == "not_started" || $state == "stopped" ]]; then
        state="running"
        start_time=$(date +%s)
        notify-send "Tomato Clock" "Timer started! ⏰"
    elif [[ $state == "running" ]]; then
        state="stopped"
        # Update remaining time when paused
        current_time=$(date +%s)
        elapsed=$((current_time - start_time))
        remaining=$((remaining - elapsed))
        notify-send "Tomato Clock" "Timer paused. ⏰"
    fi
    # Save state and exit
    echo "state=$state" >$STATE_FILE
    echo "mode=$mode" >>$STATE_FILE
    echo "remaining=$remaining" >>$STATE_FILE
    echo "start_time=$start_time" >>$STATE_FILE
    exit 0
elif [[ $1 == "right" ]]; then
    # Right click: Switch mode while preserving state
    if [[ $mode == "work" ]]; then
        mode="break"
        remaining=$BREAK_DURATION
        notify-send "Tomato Clock" "Switched to Break Mode ☕"
    else
        mode="work"
        remaining=$WORK_DURATION
        notify-send "Tomato Clock" "Switched to Work Mode 🍅"
    fi
    # Save state and exit
    echo "state=$state" >$STATE_FILE
    echo "mode=$mode" >>$STATE_FILE
    echo "remaining=$remaining" >>$STATE_FILE
    echo "start_time=$start_time" >>$STATE_FILE
    exit 0
fi

# Timer logic (only if running)
if [[ $state == "running" ]]; then
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    if ((elapsed >= remaining)); then
        # Switch mode when timer ends
        if [[ $mode == "work" ]]; then
            mode="break"
            remaining=$BREAK_DURATION
            notify-send "Tomato Clock" "Work session complete! Time for a break ☕"
        else
            mode="work"
            remaining=$WORK_DURATION
            notify-send "Tomato Clock" "Break time over! Back to work 🍅"
        fi
        # Reset timer but keep it paused
        state="stopped"
        start_time=0
    else
        # Update remaining time
        remaining=$((remaining - elapsed))
        start_time=$current_time
    fi
fi

# Save updated state
echo "state=$state" >$STATE_FILE
echo "mode=$mode" >>$STATE_FILE
echo "remaining=$remaining" >>$STATE_FILE
echo "start_time=$start_time" >>$STATE_FILE

# Format output
if [[ $state == "not_started" ]]; then
    echo "🍅"
elif [[ $state == "stopped" ]]; then
    if [[ $mode == "work" ]]; then
        echo "🍅 P $((remaining / 60))m$((remaining % 60))s"
    else
        echo "☕ P $((remaining / 60))m$((remaining % 60))s"
    fi
elif [[ $state == "running" ]]; then
    if [[ $mode == "work" ]]; then
        echo "🍅 $((remaining / 60))m$((remaining % 60))s"
    else
        echo "☕ $((remaining / 60))m$((remaining % 60))s"
    fi
else
    echo "🍅"
fi
