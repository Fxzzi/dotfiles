#!/usr/bin/env sh

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/wallust/"
LAST_WALLPAPER_FILE="/tmp/last_wallpaper"

case $1 in
    random)
        # Get a new random wallpaper, but ensure it's not the same as the last one
        WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
        
        if [ -f "$LAST_WALLPAPER_FILE" ]; then
            LAST_WALLPAPER=$(cat "$LAST_WALLPAPER_FILE")
            while [ "$WALLPAPER" = "$LAST_WALLPAPER" ]; do
                WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
            done
        fi
        ;;
    *)
        WALLPAPER="$1"
        ;;
esac

# Set the new wallpaper
swww img "$WALLPAPER" --transition-type wipe --transition-fps 60 --transition-duration 0.2 --transition-step 205
wallust run "$WALLPAPER"

# Save the current wallpaper to the last wallpaper file
echo "$WALLPAPER" > "$LAST_WALLPAPER_FILE"

# Restart services
systemctl restart --user dunst &
pywalfox --browser librewolf update &
