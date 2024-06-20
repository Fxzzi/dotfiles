
#!/usr/bin/env sh

# Check if the required input file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 input_file [output_resolution]"
    exit 1
fi

input_file="$1"
output_resolution="$2"
temp_file="temp.mp4"
output_file="${input_file%.*}-scaled.mp4"
target_filesize=25000000  # 25 MB in bytes

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

# Function to get file size in bytes
get_file_size() {
    stat -c%s "$1"
}

# Function to encode video with a specified CR
encode_video() {
    ffmpeg -y \
        -threads 11 \
        -hwaccel cuda \
        -hwaccel_output_format cuda \
        -i "$input_file" \
        -vf "scale_cuda=$output_resolution" \
        -c:a copy \
        -c:v h264_nvenc \
        -crf "$1" \
        "$temp_file"
}

# Loop to find the optimal CR to keep file size < 25 MB
for crf in $(seq 20 1 30); do
    encode_video "$crf"
    filesize=$(get_file_size "$temp_file")
    if [ "$filesize" -le "$target_filesize" ]; then
        mv "$temp_file" "$output_file"
        echo "Video encoded with CRF $crf. File size: $filesize bytes."
        exit 0
    fi
done

echo "Unable to find suitable CRF to keep file size below 25 MB."
exit 1
