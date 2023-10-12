#!/usr/bin/env sh

killall waybar # Kill all instances of waybar
waybar &       # Launch statusbar

killall swaybg # Kill all instances of swaybg
swaybg -m fill -i ~/Pictures/Wallpapers/tokyonight/tokyonight_wallhaven-1p398w.jpg &
