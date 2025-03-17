#!/bin/bash
# random-wallpaper.sh - Set a random wallpaper from a directory

# Wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/Pictures/Wallpapers"
DISABLED_DIR="disabled"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory does not exist: $WALLPAPER_DIR" >&2
    exit 1
fi

# Get a random wallpaper
# WALLPAPER=$(find "$WALLPAPER_DIR" -not -path "$WALLPAPER_DIR/$DISABLED_DIR/*" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1)
WALLPAPER=$(fd . "$WALLPAPER_DIR" --exclude "$DISABLED_DIR" -e jpg -e jpeg -e png -e gif | shuf -n 1)

# Check if a wallpaper was found
if [ -z "$WALLPAPER" ]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR" >&2
    exit 1
fi

# Set the wallpaper
if command -v feh &>/dev/null; then
    feh --bg-fill "$WALLPAPER"
    echo "Wallpaper set: $WALLPAPER"
else
    echo "Error: feh is not installed. Please install feh to set wallpapers." >&2
    exit 1
fi
