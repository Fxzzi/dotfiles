#!/usr/bin/env sh

# Screenshot the entire monitor, a selection, or active window
# and then copies the image to your clipboard. It also saves the image locally.

fileName="Screenshot from $(date '+%y.%m.%d %H:%M:%S').png"
screenshotDir="$HOME/Pictures/Screenshots"
path="$screenshotDir/$fileName"
echo $path

show_usage() {
	echo "Usage: $(basename "$0") [--monitor|--selection|--active]" >&2
	echo "Options:"
	echo "  --monitor     Take a screenshot of the active monitor"
	echo "  --selection   Take a screenshot of a rectangle selection"
	echo "  --active      Take a screenshot of the active window"
}

case $1 in
--monitor1)
	grim -o DP-2 "$path"
	;;
--monitor2)
	grim -o DP-1 "$path"
	;;
--selection)
  grim -g "$(slurp)" "$path"
	;;
--active)
  grim -g "$(echo "$(hyprctl activewindow -j)" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$path"
	;;
*)
	show_usage
	exit 1
	;;
esac

# Check file size (if the screenshot was cancelled)
fileSize=$(wc -c <"$path")

if [ "$fileSize" != 0 ]; then
	canberra-gtk-play -i camera-shutter &
	dunstify -i "$path" -a "screenshot" "Screenshot Copied" "Your screenshot has been copied to the clipboard" &
	wl-copy < "$path"
	exit 0
fi

echo "Screenshot cancelled."
exit 1
