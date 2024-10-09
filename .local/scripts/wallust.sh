#!/usr/bin/env sh

pidof hyprpaper || hyprpaper

wallust run "$1" &

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$1"
hyprctl hyprpaper wallpaper ,"$1"

# while wallust is still running, wait
while pgrep -x wallust >/dev/null; do
	sleep 0.5
done

# Restart dunst and update pywalfox
pkill dunst &
pywalfox --browser librewolf update
