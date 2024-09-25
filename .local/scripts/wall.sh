#!/usr/bin/env sh

case $1 in
	random)
		WALLPAPER_DIR="$HOME/Pictures/Wallpapers/wallust/"
		WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
		;;
	*)
		WALLPAPER="$1"
		;;
esac

swww img "$WALLPAPER" --transition-type wipe --transition-fps 60 --transition-duration 1 --transition-step 180
# Set the wallpaper
wallust run "$WALLPAPER"

systemctl restart --user dunst &
pywalfox --browser librewolf update &
