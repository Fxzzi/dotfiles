#!/bin/sh

# Terminate already running bar instances
# killall -q polybar
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar main 2>&1 | tee -a /tmp/polybar.log & disown
polybar second 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
