#!/bin/sh

# Screenshot the entire monitor, a selection, or active window
# and then copys the image to your clipboard.

tmpImage=$(mktemp /tmp/tmpImage.XXXXXXXXXX.png) # Makes a temporary file to save the screenshot to

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
    echo 'wrong or missing argument'
    ;;
esac

# check file size (if the screenshot was cancelled)
tmpImageSize=$(wc -c <"$tmpImage")

if [ $tmpImageSize != 0 ]; then
        canberra-gtk-play -i camera-shutter &
        dunstify -i "$tmpImage" -a "screenshot" "Screenshot Copied" "Your screenshot has been copied to the clipboard"
        wl-copy < "$tmpImage"
        exit $?
fi

echo "Screenshot cancelled."
exit 1
