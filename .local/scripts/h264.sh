#!/usr/bin/env sh

# Check if the required input file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 input_file"
    exit 1
fi

input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

ffmpeg -y \
    -v quiet -stats \
    -threads 11 \
    -hwaccel cuda \
    -hwaccel_output_format cuda \
    -i "$input_file" \
    -c:a copy \
    -c:v h264_nvenc \
		-cq:v 20 \
    "${input_file%.*}-h264.mp4"
