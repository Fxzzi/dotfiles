#!/usr/bin/env sh

# Function to send brightness change notification
notification() {
    # Get current brightness level using ddcutil
    brightness=$(ddcutil getvcp x10 | grep -oP 'current value\s*=\s*\K\d+')
    # Send notification about the brightness change
    dunstify -a "brightness" -u low -r "9999" -t 2000 -h int:value:"$brightness" -i "notification-display-brightness" "Brightness" "${brightness}%"
}

# Function to display script usage information
show_help() {
    echo "Usage: brightness.sh [up|down]"
    echo "Adjusts the screen brightness by increments of 10."
    echo "Arguments:"
    echo "  up: Increase brightness by 10."
    echo "  down: Decrease brightness by 10."
    echo "Example: brightness.sh up"
}

# Main script logic
case $1 in
    help)
        show_help
        exit 0
        ;;
    up)
        # Increase brightness by 10
        ddcutil setvcp 10 + 10 --display 1
				ddcutil setvcp 10 + 10 --display 2
        ;;
    down)
        # Decrease brightness by 10
        ddcutil setvcp 10 - 10 --display 1
				ddcutil setvcp 10 - 10 --display 2
        ;;
    *)
        show_help
        exit 1
        ;;
esac

# Send notification after adjusting brightness
notification
exit 0
