#!/usr/bin/env sh

killall waybar # Kill all instances of waybar
waybar & # Launch statusbar

killall swaybg # Kill all instances of swaybg
swaybg -m fill -i "$(find ~/Pictures/Wallpapers/fav/ -type f | shuf -n 1)" # Set random background from favourites
