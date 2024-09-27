#!/usr/bin/env sh

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/wallust/"
INDEX_FILE="$HOME/.config/hypr/hyprpaper-index.txt"

# Get all wallpapers into an array
WALLPAPER_LIST=("$WALLPAPER_DIR"/*)

# Initialize index file if it doesn't exist
if [ ! -f "$INDEX_FILE" ]; then
    echo 0 > "$INDEX_FILE"
fi

# Read the current index
INDEX=$(<"$INDEX_FILE")
INDEX=$((INDEX % ${#WALLPAPER_LIST[@]}))  # Wrap around if necessary

# Select the wallpaper based on the index
WALLPAPER=${WALLPAPER_LIST[$INDEX]}

# Set the wallpaper
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ", $WALLPAPER"

wallust run "$WALLPAPER"

# Increment and save the index
INDEX=$((INDEX + 1))
echo "$INDEX" > "$INDEX_FILE"

systemctl --user restart dunst.service
pywalfox --browser librewolf update &
