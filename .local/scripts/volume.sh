#!/bin/sh

send_notification() {
	volume=$(pamixer --get-volume)
    if [ ${volume} -gt 70 ]; then icon=notification-audio-volume-high
    elif [ ${volume} -gt  40 ]; then icon=notification-audio-volume-medium
    elif [ ${volume} -gt 0 ]; then icon=notification-audio-volume-low
    else icon=notification-audio-volume-muted
    fi
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "$icon" "Volume: ${volume}%" -t 2000
    canberra-gtk-play -i audio-volume-change -d "changeVolume" &
  }

case $1 in
up)
	# Set the volume on (if it was muted)
	pamixer -u
	pamixer -i 5
	send_notification "$1"
	;;
down)
	pamixer -u
	pamixer -d 5
	send_notification "$1"
	;;
mute)
	pamixer -t
	if eval "$(pamixer --get-mute)"; then
		dunstify -i notification-audio-volume-muted -a "changevolume" -t 2000 -r 9993 -u low "Muted"
	else
		send_notification up
	fi
	;;
esac
