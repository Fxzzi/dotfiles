#!/usr/bin/env sh

# Function to send brightness change notification
notification() {
    # Get current brightness level
    brightness="$(xbacklight -get)"
    # Send notification about the brightness change
    dunstify -a "brightness" -u low -r "9999" -t 2000 -h int:value:"$brightness" -i "notification-display-brightness" "Brightness" "${brightness}%"
}

# Function to display script usage information
show_help() {
    echo "Usage: brightness.sh [up|down] [increment_value]"
    echo "Adjusts the screen brightness."
    echo "Arguments:"
    echo "  up: Increase brightness by the specified increment value."
    echo "  down: Decrease brightness by the specified increment value."
    echo "  increment_value: Positive increment value to change by."
    echo "Example: brightness.sh up 10"
}

# Main script logic
case $1 in
    help)
        show_help
        exit 0
        ;;
    up)
        # Increase brightness by the specified increment value
        xbacklight -inc "$2"
        ;;
    down)
        # Decrease brightness by the specified increment value
        xbacklight -dec "$2"
        ;;
    *)
        show_help
        exit 1
        ;;
esac

# Send notification after adjusting brightness
notification
exit 0
