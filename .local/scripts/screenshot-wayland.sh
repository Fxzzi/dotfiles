#!/bin/sh

# Screenshot either monitor, a selection, or active window with maim
# and then uploads with curl, copying the link to your
# clipboard, and saving the screenshot with a timestamp.

tmpImage=$(mktemp /tmp/tmpImage.XXXXXXXXXX --suffix .png) # Makes a temporary file to save the screenshot to

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
        cp $tmpImage $HOME/Pictures/Screenshots/"Screenshot from $(date '+%d.%m.%y %H:%M:%S').png"
        curl --request POST \
        --url https://api.upload.systems/images/upload \
        --header 'Content-Type: multipart/form-data' \
        --form key=$(cat $HOME/Documents/uploadKey) \
        --form file="@$tmpImage" | \
        jq -r '.url' | wl-copy -n
        dunstify -i "$tmpImage" -a "screenshot" "Screenshot Copied" "Your screenshot has been copied to the clipboard"
        canberra-gtk-play -i message &
        exit $?
fi

echo "Screenshot cancelled."
exit 1
