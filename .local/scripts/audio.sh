#!/usr/bin/env sh

# Function to handle volume notifications
volume_noti(){
    volume=$(pamixer --get-volume)
    if [ "${volume}" -gt 70 ]; then
        icon=notification-audio-volume-high
    elif [ "${volume}" -gt 40 ]; then
        icon=notification-audio-volume-medium
    else
        icon=notification-audio-volume-low
    fi

    # Send volume change notification
    dunstify -a "audio" -r "9997" -h int:value:"$volume" -i "$icon" "Volume" "${volume}%"     # Play sound to indicate volume change
    canberra-gtk-play -i audio-volume-change &
}

# Function to handle sink toggle notifications
sink_toggle_noti(){
    if eval "$(pamixer --get-mute)"; then
        # Send notification when sink is muted
        dunstify -i notification-audio-volume-muted -a "audio" -r 9997 "Volume" "Muted"
    else
        volume_noti
    fi
}

# Function to handle source toggle notifications
source_toggle_noti(){
    if eval "$(pamixer --default-source --get-mute)"; then
        # Send notification when source is muted
        dunstify -i audio-input-microphone-muted-symbolic -a "audio" -r 9996 "Microphone" "Muted"
    else
        # Send notification when source is unmuted
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
                pamixer -u
                pamixer -i "$3"
                volume_noti
                exit 0
                ;;
            down)
                pamixer -u
                pamixer -d "$3"
                volume_noti
                exit 0
                ;;
            toggle)
                pamixer -t
                sink_toggle_noti
                exit 0
                ;;
        esac
        ;;
    mic)
        case $2 in
            toggle)
                pamixer --default-source -t
                source_toggle_noti
                exit 0
                ;;
        esac
        ;;
    *)
        echo "Invalid command: $1"
        show_help
        exit 1
        ;;
esac
