#!/usr/bin/env sh

if [ -z "$1" ]; then
	echo "add wallpaper as arg"
	exit 1
fi

pidof hyprpaper || (hyprpaper & sleep 1) 

wallust run "$1" &

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$1"
hyprctl hyprpaper wallpaper ,"$1"

# while wallust is still running, wait
while pgrep -x wallust >/dev/null; do
	sleep 1
done

# Restart dunst and update pywalfox
pkill dunst &
pywalfox --browser librewolf update
