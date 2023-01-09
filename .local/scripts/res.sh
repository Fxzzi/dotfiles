#!/bin/sh

# Disable screen blanking / screensavers
xset s off &
xset -dpms &

# Max Res and Refresh Rate
xrandr --output DP-2 --primary --mode 2560x1440 --rate 169.83 --output DP-0 --mode 1920x1080 -o normal --left-of DP-2 --rate 74.97

# Both 1080p, Max Refresh Rate (Rocket League)
#xrandr --output DP-2 --primary --mode 1920x1080 --rate 169.83 --output DP-0 --mode 1920x1080 -o normal --left-of DP-2 --rate 74.97  

# Max Res, 60Hz (Fireboy and Watergirl)
#xrandr --output DP-2 --primary --mode 2560x1440 --rate 59.95 --output DP-0 --mode 1920x1080 -o normal --left-of DP-2 --rate 60.00
