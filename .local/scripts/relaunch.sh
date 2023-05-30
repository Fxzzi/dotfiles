#!/usr/bin/env sh

killall waybar
waybar -c "$XDG_CONFIG_HOME"/waybar/config-dp-2.jsonc & # Waybar main monitor
waybar -c "$XDG_CONFIG_HOME"/waybar/config-dp-1.jsonc & # Waybar secondary monitor

killall swaybg
swaybg -m fill -i ~/Pictures/Wallpapers/orig/mchouse.png
