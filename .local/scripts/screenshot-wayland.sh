#!/usr/bin/env sh

# Screenshot either monitor, a selection, or active window with maim
# and then uploads with curl, copying the link to your
# clipboard, and saving the screenshot with a timestamp.

tmpImage=$(mktemp /tmp/tmpImage.XXXXXXXXXX.png) # Makes a temporary file to save the screenshot to

show_usage() {
	echo "Usage: $(basename "$0") [--monitor|--selection|--active]" >&2
	echo "Options:"
	echo "  --monitor     Take a screenshot of the active monitor"
	echo "  --selection   Take a screenshot of a rectangle selection"
	echo "  --active      Take a screenshot of the active window"
}

case $1 in
--monitor)
	grimblast save output "$tmpImage"
	;;
--selection)
	grimblast save area "$tmpImage"
	;;
--active)
	grimblast save active "$tmpImage"
	;;
*)
	show_usage
	exit 1
	;;
esac

# check file size (if the screenshot was cancelled)
tmpImageSize=$(wc -c <"$tmpImage")

if [ "$tmpImageSize" -ne 0 ]; then
	canberra-gtk-play -i camera-shutter &
	cp "$tmpImage" "$HOME/Pictures/Screenshots/Screenshot from $(date '+%d.%m.%y %H:%M:%S').png"
	curl --request POST \
		--url https://api.upload.systems/images/upload \
		--header 'Content-Type: multipart/form-data' \
		--form key="$(cat "$HOME/Documents/uploadKey")" \
		--form file="@$tmpImage" |
		jq -r '.url' | wl-copy -n
	dunstify -i "$tmpImage" -a "screenshot" "Screenshot Copied" "Your screenshot has been copied to the clipboard"
	canberra-gtk-play -i message &
	exit 0
fi

echo "Screenshot cancelled."
exit 1
