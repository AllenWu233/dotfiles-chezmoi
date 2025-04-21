#!/bin/bash

# Check if sufficient arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 [convert|cut] [input_file] [additional_args...]"
    exit 1
fi

# First argument specifies the action
ACTION=$1
INPUT_FILE=$2

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' does not exist."
    exit 1
fi

# Function to detect GPU type
detect_gpu() {
    if command -v nvidia-smi >/dev/null 2>&1; then
        GPU_COUNT=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
        if [ "$GPU_COUNT" -gt 0 ]; then
            echo "NVIDIA GPU detected: $(nvidia-smi --query-gpu=name --format=csv,noheader | head -n 1)"
            GPU_TYPE="nvidia"
            return 0
        fi
    elif command -v rocm-smi >/dev/null 2>&1; then
        GPU_COUNT=$(rocm-smi --showproductname | grep -c "gfx")
        if [ "$GPU_COUNT" -gt 0 ]; then
            echo "AMD GPU detected: $(rocm-smi --showproductname | grep 'gfx' | head -n 1)"
            GPU_TYPE="amd"
            return 0
        fi
    fi
    echo "No GPU detected. Falling back to CPU."
    GPU_TYPE="none"
    return 1
}

# Detect GPU and set acceleration options
GPU_ACCEL_OPTIONS=""
detect_gpu
if [ "$GPU_TYPE" == "nvidia" ]; then
    GPU_ACCEL_OPTIONS="-hwaccel cuda -c:v h264_cuvid -c:a copy"
    echo "Using NVIDIA GPU acceleration."
elif [ "$GPU_TYPE" == "amd" ]; then
    GPU_ACCEL_OPTIONS="-hwaccel vulkan -c:v h264_amf -c:a copy"
    echo "Using AMD GPU acceleration."
else
    echo "Using CPU (no GPU detected)."
fi

# Handle the 'convert' action
if [ "$ACTION" == "convert" ]; then
    # Ensure output format is provided
    if [ $# -lt 3 ]; then
        echo "Error: Output format must be specified for 'convert'."
        echo "Usage: $0 convert [input_file] [output_format] [output_file (optional)]"
        exit 1
    fi

    OUTPUT_FORMAT=$3
    OUTPUT_FILE=${4:-"${INPUT_FILE%.*}.$OUTPUT_FORMAT"}

    # Execute ffmpeg to convert the file
    echo "Converting '$INPUT_FILE' to format '$OUTPUT_FORMAT'..."
    ffmpeg -i "$INPUT_FILE" $GPU_ACCEL_OPTIONS "$OUTPUT_FILE"

    if [ $? -eq 0 ]; then
        echo "Conversion successful! Output file: $OUTPUT_FILE"
    else
        echo "Conversion failed."
        exit 1
    fi

# Handle the 'cut' action
elif [ "$ACTION" == "cut" ]; then
    # Ensure start time, duration, and output file are provided
    if [ $# -lt 5 ]; then
        echo "Error: Start time, duration, and output file must be specified for 'cut'."
        echo "Usage: $0 cut [input_file] [start_time] [duration] [output_file]"
        echo "Example: $0 cut input.mp4 00:00:10 00:00:30 output.mp4"
        exit 1
    fi

    START_TIME=$3
    DURATION=$4
    OUTPUT_FILE=$5

    # Execute ffmpeg to cut the video
    echo "Cutting '$INPUT_FILE' from $START_TIME for $DURATION..."
    ffmpeg -i "$INPUT_FILE" -ss "$START_TIME" -t "$DURATION" -c copy $GPU_ACCEL_OPTIONS "$OUTPUT_FILE"

    if [ $? -eq 0 ]; then
        echo "Cutting successful! Output file: $OUTPUT_FILE"
    else
        echo "Cutting failed."
        exit 1
    fi

# Handle invalid actions
else
    echo "Error: Invalid action '$ACTION'. Valid actions are 'convert' and 'cut'."
    echo "Usage: $0 [convert|cut] [input_file] [additional_args...]"
    exit 1
fi
