#!/usr/bin/env sh

WALLPAPER_DIR="$HOME/walls/"
INDEX_FILE="/tmp/wallust-index"

# Create index file if it doesn't exist, defaulting to -1
[ ! -f "$INDEX_FILE" ] && echo -1 > "$INDEX_FILE"

# Read the current index and get the list of images with specific extensions
mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

# Calculate the next index
NEXT_INDEX=$(( ($(<"$INDEX_FILE") + 1) % ${#IMAGES[@]} ))

# Save updated index
echo "$NEXT_INDEX" > "$INDEX_FILE"

# Apply the new wallpaper
WALLPAPER="${IMAGES[$NEXT_INDEX]}"

wallust.sh "$WALLPAPER"
