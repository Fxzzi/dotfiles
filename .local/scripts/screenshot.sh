#!/usr/bin/env sh

# Screenshot the entire monitor, a selection, or active window
# and then copies the image to your clipboard.
# It also saves the image locally.

fileName="Screenshot from $(date '+%y.%m.%d %H:%M:%S').png"
screenshotDir="$HOME/Pictures/Screenshots"
path="$screenshotDir/$fileName"

if [ ! -d "$screenshotDir" ]; then
    mkdir -p "$screenshotDir"
    echo "Directory '$screenshotDir' created successfully."
fi

show_usage() {
    echo "Usage: $(basename "$0") [--monitor|--selection|--active]" >&2
    echo "Options:"
    echo "  --monitor     Take a screenshot of the entire monitor"
    echo "  --selection   Take a screenshot of a rectangle selection"
    echo "  --active      Take a screenshot of the active window"
}

case $1 in
    --monitor)
        grim -t png -l 1 -o DP-3 "$path"
        ;;
    --selection)
        grim -t png -l 1 -g "$(slurp)" "$path"
        ;;
    --active)
        grim -t png -l 1 -g "$(echo "$(hyprctl activewindow -j)" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$path"
        ;;
    *)
        show_usage
        exit 1
        ;;
esac

if [ -f "$path" ]; then
    canberra-gtk-play -i camera-shutter -V "-8" &
    dunstify -i "$path" -a "screenshot" "Screenshot" "Copied to clipboard" -r 9998 &
    wl-copy <"$path"
    exit 0
fi

echo "Screenshot cancelled."
exit 1
