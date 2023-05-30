#!/usr/bin/env sh

send_notification() {
	volume=$(pamixer --get-volume)
	if [ "${volume}" -gt 70 ]; then
		icon=audio-volume-high
	elif [ "${volume}" -gt 40 ]; then
		icon=audio-volume-medium
	elif [ "${volume}" -gt 0 ]; then
		icon=audio-volume-low
	else
		icon=audio-volume-muted
	fi
	dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "$icon" "Volume: ${volume}%" -t 2000
	canberra-gtk-play -i audio-volume-change -d "changeVolume" &
}

show_usage() {
	echo "Usage: $(basename "$0") [up|down|mute]" >&2
	echo "  up         Increase volume by 5%"
	echo "  down       Decrease volume by 5%"
	echo "  mute       Toggle mute/unmute"
}

case $1 in
up)
	# Set the volume on (if it was muted)
	pamixer -u
	pamixer -i 5
	send_notification "$1"
	exit 0
	;;
down)
	pamixer -u
	pamixer -d 5
	send_notification "$1"
	exit 0
	;;
mute)
	pamixer -t
	if eval "$(pamixer --get-mute)"; then
		dunstify -i audio-volume-muted -a "changevolume" -t 2000 -r 9993 -u low "Muted"
	else
		send_notification up
	fi
	exit 0
	;;
*)
	show_usage
	exit 1
	;;
esac
