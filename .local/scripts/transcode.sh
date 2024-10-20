#!/usr/bin/env sh

# Check if the required input file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 input_file [output_resolution]"
    exit 1
fi

input_file="$1"
output_resolution="$2"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

# Execute ffmpeg command with or without scaling filter based on output resolution
if [ -n "$output_resolution" ]; then
    ffmpeg -y \
				-v quiet -stats \
        -i "$input_file" \
        -vf "scale_cuda=$output_resolution" \
        -c:a copy \
        -c:v h264 \
        -cq:v 27 \
        "${input_file%.*}-scaled.mp4"
else
    ffmpeg -y \
				-v quiet -stats \
        -i "$input_file" \
        -c:a copy \
        -c:v h264 \
        -cq:v 27 \
        "${input_file%.*}-scaled.mp4"
fi
