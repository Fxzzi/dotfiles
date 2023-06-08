#!/usr/bin/env sh

killall waybar # Kill all instances of waybar
waybar & # Launch statusbar

killall swaybg # Kill all instances of swaybg
swaybg -m fill -i ~/Pictures/Wallpapers/orig/mchouse.png # Set background
