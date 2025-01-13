#!/bin/bash
# This script backs up the Vintage Story save file to a specified directory.
# It creates a new directory for each backup, named with the current date and time.
# It also creates a compressed archive of the save file.
#
# Usage: saves-bkp.sh
#
BACKUP_DIR="$HOME/Games/Games/VintageStory/saves/robinson-crusoe"
SAVE_DIR="$HOME/.config/VintagestoryData/Saves/"
SAVE="robinson crusoe.vcdbs"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
TAR_FILE="$DATE.tar.gz"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Created backup directory $BACKUP_DIR"
fi

cd "$SAVE_DIR" || exit
tar -czf "$TAR_FILE" "$SAVE"
mv "$TAR_FILE" "$BACKUP_DIR/"
echo "Backup saved to $BACKUP_DIR/$TAR_FILE"
