#!/usr/bin/env sh

# Function to handle volume notifications
volume_noti() {
	volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')

	case 1 in
	$(($volume > 70))) icon=notification-audio-volume-high ;;
	$(($volume > 40))) icon=notification-audio-volume-medium ;;
	*) icon=notification-audio-volume-low ;;
	esac

	dunstify -a "audio" -r "9997" -h int:value:"$volume" -i "$icon" "Volume" "${volume}%"
	canberra-gtk-play -i audio-volume-change &
}

# Function to handle sink notifications
sink_noti() {
	if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"; then
		dunstify -i notification-audio-volume-muted -a "audio" -r 9997 "Volume" "Muted"
	else
		volume_noti
	fi
}

# Function to handle source notifications
source_noti() {
	if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
		dunstify -i audio-input-microphone-muted-symbolic -a "audio" -r 9996 "Microphone" "Muted"
	else
		dunstify -i audio-input-microphone-symbolic -a "audio" -r 9996 "Microphone" "Unmuted"
	fi
}

# Function to display script usage information
show_help() {
	echo "Usage: audio.sh [command] [options]"
	echo ""
	echo "Commands:"
	echo "  vol up {step}     Increase the volume by the specified step"
	echo "  vol down {step}   Decrease the volume by the specified step"
	echo "  vol toggle        Toggle the audio output on/off"
	echo "  mic toggle        Toggle the microphone on/off"
	echo ""
	echo "Options:"
	echo "  {step}            The amount by which to increase or decrease the volume"
	echo ""
}

# Main script logic
case $1 in
help)
	show_help
	exit 0
	;;
vol)
	case $2 in
	up)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
		wpctl set-volume @DEFAULT_AUDIO_SINK@ "$3%+" --limit 1.0
		volume_noti
		exit 0
		;;
	down)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
		wpctl set-volume @DEFAULT_AUDIO_SINK@ "$3%-"
		volume_noti
		exit 0
		;;
	toggle)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
		sink_noti
		exit 0
		;;
	esac
	;;
mic)
	[ "$2" = "toggle" ] && wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && source_noti
	exit 0
	;;
*)
	echo "Invalid command: $1"
	show_help
	exit 1
	;;
esac
