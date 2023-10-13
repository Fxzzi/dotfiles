#!/usr/bin/env sh

send_notification() {
	local brightness=$(xbacklight -get) # Get current brightness level
	dunstify -a "changebrightness" -u low -r "9999" -h int:value:"$brightness" -i "notification-display-brightness" "Brightness: ${brightness}%" -t 2000
}

show_usage() {
	echo "Usage: $(basename "$0") [up|down]" >&2
	echo "  up         Increase brightness by a factor of 5"
	echo "  down       Decrease brightness by a factor of 5"
}

case $1 in
up)
	xbacklight -inc 5 # Increase brightness by a factor of 5
	;;
down)
	xbacklight -dec 5 # Decrease brightness by a factor of 5
	;;
*)
	show_usage
	exit 1
	;;
esac

send_notification
exit 0
