#!/bin/bash
if [ "$3" ]; then
    ffmpeg -i "$1" -ss "$2" -to "$3" -c copy "[$2-$3]$1"
else
    ffmpeg -i "$1" -ss "$2" -c copy "[$2-]$1"
fi
