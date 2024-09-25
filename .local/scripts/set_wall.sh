#!/usr/bin/env sh

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/wallust/"

# Kill any existing wallpaper setting processes
pkill wbg

# Select a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Set the wallpaper
wbg "$WALLPAPER" &
wallust run "$WALLPAPER"
pywalfox --browser librewolf update &

