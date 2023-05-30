#!/usr/bin/env sh

# Screenshot the entire monitor, a selection, or active window
# and then copies the image to your clipboard. It also saves the image locally.

tmpImage=$(mktemp /tmp/tmpImage.XXXXXXXXXX.png) # Makes a temporary file to save the screenshot to

show_usage() {
	echo "Usage: $(basename "$0") [--monitor|--selection|--active]" >&2
	echo "Options:"
	echo "  --monitor     Take a screenshot of the active monitor"
	echo "  --selection   Take a screenshot of a rectangle selection"
	echo "  --active      Take a screenshot of the active window"
}

case $1 in
# Takes screenshot of active monitor
--monitor)
	grimblast save output "$tmpImage"
	;;
	# Takes screenshot of rectangle selection
--selection)
	grimblast save area "$tmpImage"
	;;
	# Takes screenshot of active window
--active)
	grimblast save active "$tmpImage"
	;;
*)
	show_usage
	exit 1
	;;
esac

# Check file size (if the screenshot was cancelled)
tmpImageSize=$(wc -c <"$tmpImage")

if [ "$tmpImageSize" != 0 ]; then
	canberra-gtk-play -i camera-shutter &
	cp "$tmpImage" "$HOME/Pictures/Screenshots/Screenshot from $(date '+%d.%m.%y %H:%M:%S').png"
	dunstify -i "$tmpImage" -a "screenshot" "Screenshot Copied" "Your screenshot has been copied to the clipboard"
	wl-copy <"$tmpImage"
	exit 0
fi

echo "Screenshot cancelled."
exit 1
