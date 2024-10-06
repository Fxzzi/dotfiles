#!/usr/bin/env sh

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$1"
hyprctl hyprpaper wallpaper ,"$1"

wallust run "$1"

# Restart dunst and update pywalfox in background
pkill dunst & pywalfox --browser librewolf update
