#!/bin/bash
# Fix network connection after resuming from hibernate

MOD="r8169"
LOG_FILE="/var/log/network-resume.log"

# Output to both terminal and log file
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=== [$(date)] Starting to reload module $MOD ==="

# Remove module
if rmmod "$MOD" &>/dev/null; then
    echo "Module $MOD removed"
else
    echo "Error: Failed to remove $MOD (root permission required)"
    exit 1
fi

# Reload module
if modprobe "$MOD"; then
    echo "Module $MOD reloaded"
else
    echo "Error: Failed to load $MOD"
    exit 1
fi

echo "=== Operation completed ==="
