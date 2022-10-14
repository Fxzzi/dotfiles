#!/bin/bash

# Screenshot either monitor, a selection, or active window
# and then uploads with sharenix, copying the link to your
# clipboard.

tmpImage=$(mktemp /tmp/tmpImage.XXXXXXXXXX.png) # Makes a temporary file to save the screenshot to

case $1 in
# Takes screenshot of primary monitor
  --monitor1)
    maim -Bu -m 3 -g 2560x1440+1920+0 "$tmpImage"
    ;;
# Takes screenshot of secondary monitor
  --monitor2)
    maim -Bu -m 3 -g 1920x1080+0+0 "$tmpImage"
    ;;
# Takes screenshot of rectangle selection
  --selection)
    maim -sBu -m 3 "$tmpImage"
    ;;
# Takes screenshot of active window
  --active)
    maim -Bu -m 3 --window $(xdotool getactivewindow) "$tmpImage"
    ;;
  *)
    echo 'wrong or missing argument'
    ;;
esac

# check file size (if the screenshot was cancelled)
tmpImageSize=$(wc -c <"$tmpImage")

if [ $tmpImageSize != 0 ]; then
        dunstify -i "$tmpImage" -a "screenshot" "Screenshot Copied" "Your screenshot has been copied to the clipboard"
        sharenix -c -q "$tmpImage"
        exit $?
fi

echo "Screenshot cancelled."
exit 1
