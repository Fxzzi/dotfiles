#!/usr/bin/env sh

# Function to send brightness change notification
notification() {
	# Get current brightness level using ddcutil
	brightness=$(ddcutil getvcp x10 | grep -oP 'current value\s*=\s*\K\d+')
	# Send notification about the brightness change
	dunstify -a "brightness" -u low -r "9999" -t 2000 -h int:value:"$brightness" -i "notification-display-brightness" "Brightness" "${brightness}%"
}

# Main script logic
case $1 in
up)
	# Increase brightness by 10
	ddcutil setvcp 10 + 10 --skip-ddc-checks --noverify --sleep-multiplier 0.2 --bus 4
	ddcutil setvcp 10 + 10 --skip-ddc-checks --noverify --sleep-multiplier 0.2 --bus 5
	;;
down)
	# Decrease brightness by 10
	ddcutil setvcp 10 - 10 --skip-ddc-checks --noverify --sleep-multiplier 0.2 --bus 4
	ddcutil setvcp 10 - 10 --skip-ddc-checks --noverify --sleep-multiplier 0.2 --bus 5
	;;
*)
	echo "invalid cmd"
	exit 1
	;;
esac

# Send notification after adjusting brightness
notification
exit 0
