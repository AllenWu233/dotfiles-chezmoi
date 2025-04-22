#!/bin/bash
# Tomato Clock script with start/pause, mode toggle, sound effects, long break support, and i3status-rust color support

# Set durations (in seconds)
WORK_DURATION=$((25 * 60))       # 25 minutes
BREAK_DURATION=$((5 * 60))       # 5 minutes
LONG_BREAK_DURATION=$((15 * 60)) # 15 minutes
CYCLES_BEFORE_LONG_BREAK=4       # Number of cycles before a long break

# Paths to sound effects (update these paths to match your system)
CLICK_SOUND="$HOME/.config/i3status-rust/click_stereo.ogg"
BREAK_SOUND="$HOME/.config/i3status-rust/levelup.ogg"
WORK_SOUND="$HOME/.config/i3status-rust/successful_hit.ogg"

# State file to persist timer across restarts
STATE_FILE="/tmp/tomato_clock_state"

# Default state if no state file exists
if [[ ! -f $STATE_FILE ]]; then
    echo "state=not_started" >$STATE_FILE
    echo "mode=work" >>$STATE_FILE
    echo "remaining=$WORK_DURATION" >>$STATE_FILE
    echo "start_time=0" >>$STATE_FILE
    echo "work_cycles=0" >>$STATE_FILE       # Track number of work cycles completed
    echo "is_long_break=false" >>$STATE_FILE # Track if currently in long break
fi

# Load state
source $STATE_FILE

# Function to play sound using mpv
play_sound() {
    local sound_file=$1
    if [[ -f $sound_file ]]; then
        mpv --no-terminal --quiet "$sound_file" &
    fi
}

# Handle click events
if [[ $1 == "left" ]]; then
    # Left click: Start/Pause the timer
    if [[ $state == "not_started" || $state == "stopped" ]]; then
        state="running"
        start_time=$(date +%s)
        play_sound "$CLICK_SOUND"
        notify-send "Tomato Clock" "Timer started! ⏰"
    elif [[ $state == "running" ]]; then
        state="stopped"
        # Update remaining time when paused
        current_time=$(date +%s)
        elapsed=$((current_time - start_time))
        remaining=$((remaining - elapsed))
        play_sound "$CLICK_SOUND"
        notify-send "Tomato Clock" "Timer paused. ⏰"
    fi
    # Save state and exit
    echo "state=$state" >$STATE_FILE
    echo "mode=$mode" >>$STATE_FILE
    echo "remaining=$remaining" >>$STATE_FILE
    echo "start_time=$start_time" >>$STATE_FILE
    echo "work_cycles=$work_cycles" >>$STATE_FILE
    echo "is_long_break=$is_long_break" >>$STATE_FILE
    exit 0
elif [[ $1 == "right" ]]; then
    # Right click: Switch mode while preserving state
    if [[ $mode == "work" ]]; then
        # Switch to break mode
        if [[ $work_cycles == $((CYCLES_BEFORE_LONG_BREAK - 1)) ]]; then
            # Enter long break if cycles are full
            mode="break"
            remaining=$LONG_BREAK_DURATION
            is_long_break=true
        else
            # Regular short break
            mode="break"
            remaining=$BREAK_DURATION
            is_long_break=false
        fi
        play_sound "$BREAK_SOUND"
        notify-send "Tomato Clock" "Switched to Break Mode ☕"
    else
        # Switch to work mode
        if [[ $is_long_break == "true" ]]; then
            # Reset work cycles when switching from long break to work
            work_cycles=0
            is_long_break=false
        else
            # Increment work cycles only if not in long break
            if [[ $work_cycles -lt $((CYCLES_BEFORE_LONG_BREAK - 1)) ]]; then
                work_cycles=$((work_cycles + 1))
            fi
        fi
        mode="work"
        remaining=$WORK_DURATION
        play_sound "$WORK_SOUND"
        notify-send "Tomato Clock" "Switched to Work Mode 🍅"
    fi
    # Save state and exit
    echo "state=$state" >$STATE_FILE
    echo "mode=$mode" >>$STATE_FILE
    echo "remaining=$remaining" >>$STATE_FILE
    echo "start_time=$start_time" >>$STATE_FILE
    echo "work_cycles=$work_cycles" >>$STATE_FILE
    echo "is_long_break=$is_long_break" >>$STATE_FILE
    exit 0
fi

# Timer logic (only if running)
if [[ $state == "running" ]]; then
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    if ((elapsed >= remaining)); then
        # Timer ends, switch mode
        if [[ $mode == "work" ]]; then
            # Work session ends, switch to break
            if ((work_cycles + 1 >= CYCLES_BEFORE_LONG_BREAK)); then
                # Enter long break after 4 work cycles
                mode="break"
                remaining=$LONG_BREAK_DURATION
                is_long_break=true
                play_sound "$BREAK_SOUND"
                notify-send "Tomato Clock" "Work session complete! Time for a long break 󰒲"
            else
                # Regular short break
                mode="break"
                remaining=$BREAK_DURATION
                is_long_break=false
                play_sound "$BREAK_SOUND"
                notify-send "Tomato Clock" "Work session complete! Time for a break ☕"
            fi
        else
            # Break session ends, switch to work
            if [[ $is_long_break == "true" ]]; then
                work_cycles=0 # Reset work cycles after long break
                is_long_break=false
            else
                work_cycles=$((work_cycles + 1))
            fi
            mode="work"
            remaining=$WORK_DURATION
            play_sound "$WORK_SOUND"
            notify-send "Tomato Clock" "Break time over! Back to work 🍅"
        fi
        # Keep the timer running after switching modes
        start_time=$current_time
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
echo "work_cycles=$work_cycles" >>$STATE_FILE
echo "is_long_break=$is_long_break" >>$STATE_FILE

# Format output with JSON for i3status-rust
if [[ $state == "not_started" ]]; then
    echo '{"text": "󰉛"}'
elif [[ $state == "stopped" ]]; then
    if [[ $mode == "work" ]]; then
        printf '{"text": "󰉛 (%d)%dm%ds", "state": "Warning"}\n' "$work_cycles" "$((remaining / 60))" "$((remaining % 60))"
    elif [[ $is_long_break == "true" ]]; then
        printf '{"text": "󰒲  %dm%ds", "state": "Warning"}\n' "$((remaining / 60))" "$((remaining % 60))"
    else
        printf '{"text": "󰶟 (%d)%dm%ds", "state": "Warning"}\n' "$work_cycles" "$((remaining / 60))" "$((remaining % 60))"
    fi
elif [[ $state == "running" ]]; then
    if [[ $mode == "work" ]]; then
        printf '{"text": "󰉛 (%d)%dm%ds", "state": "Good"}\n' "$work_cycles" "$((remaining / 60))" "$((remaining % 60))"
    elif [[ $is_long_break == "true" ]]; then
        printf '{"text": "󰒲  %dm%ds", "state": "Good"}\n' "$((remaining / 60))" "$((remaining % 60))"
    else
        printf '{"text": "󰶟 (%d)%dm%ds", "state": "Good"}\n' "$work_cycles" "$((remaining / 60))" "$((remaining % 60))"
    fi
else
    echo '{"text": "󰉛"}'
fi
