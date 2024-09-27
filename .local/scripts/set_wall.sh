#!/usr/bin/env sh

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/wallust/"

# Select a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Set the wallpaper
hyprctl hyprpaper unload all
hyprctl hyprpaper preload $WALLPAPER
hyprctl hyprpaper wallpaper ", $WALLPAPER"

wallust run "$WALLPAPER"
pywalfox --browser librewolf update &
