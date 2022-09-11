#!/bin/bash

# Screenshot either monitor, a selection, or active window
# and then uploads with sharenix, copying the link to your
# clipboard.

tmpImage=$(mktemp /tmp/tmpImage.XXXXXXXXXX) # Makes a temporary file to save the screenshot to
mv "$tmpImage" "$tmpImage.png"
tmpImage="$tmpImage.png"

case $1 in
# Takes screenshot of primary monitor
  --monitor)
    maim -uB -m 3 "$tmpImage"
    ;;
# Takes screenshot of rectangle selection
  --selection)
    maim -suBlc '0,0,0,0.15' -m 3 "$tmpImage"
    ;;
# Takes screenshot of active window
  --active)
    maim -uB -m 3 --window $(xdotool getactivewindow) "$tmpImage"
    ;;
  *)
    echo 'wrong or missing argument'
    ;;
esac

# check file size (if the screenshot was cancelled)
tmpImageSize=$(wc -c <"$tmpImage")

if [ $tmpImageSize != 0 ]; then
        dunstify -i "$tmpImage" -a "screenshot" "Screenshot Copied" "Your screenshot has been copied to the clipboard"
        xclip -selection clipboard -t image/png -i $tmpImage
        exit $?
fi

echo "Screenshot cancelled."
exit 1
