#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/wallust/"

find "$WALLPAPER_DIR" -type f -exec hyprctl hyprpaper preload {} \;
