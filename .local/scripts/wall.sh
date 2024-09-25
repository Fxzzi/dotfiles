#!/usr/bin/env sh

case $1 in
	random)
		WALLPAPER_DIR="$HOME/Pictures/Wallpapers/orig/"
		WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
		;;
	*)
		WALLPAPER="$1"
		;;
esac

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ", "$WALLPAPER""

# Set the wallpaper
wallust run "$WALLPAPER"
pywalfox --browser librewolf update &
