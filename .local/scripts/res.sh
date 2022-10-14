#!/bin/sh
xset s off &
xset -dpms &
xrandr --output DP-2 --primary --mode 2560x1440 --rate 169.83 --output DP-0 --mode 1920x1080 -o normal --left-of DP-2 --rate 74.97
#xrandr --output DP-2 --primary --mode 2560x1440 --rate 169.83 --output DP-0 --mode 1920x1080 -o left --left-of DP-2 --rate 74.97
#xrandr --output DP-2 --primary --mode 1920x1080 --rate 169.83 --output DP-0 --mode 1920x1080 --left-of DP-2 --rate 74.97
