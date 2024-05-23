#!/usr/bin/env sh

# Set the GTK theme to TokyoNight
gsettings set org.gnome.desktop.interface gtk-theme TokyoNight
# Set the icon theme to Papirus-Dark
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
# Set the default font and size
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 12'
# Set the cursor theme and size
gsettings set org.gnome.desktop.interface cursor-theme Simp1e-Tokyo-Night
gsettings set org.gnome.desktop.interface cursor-size 24
# Set font antialiasing
gsettings set org.gnome.desktop.interface font-antialiasing rgba
# Set font hinting
gsettings set org.gnome.desktop.interface font-hinting slight
# Set preferred theme to dark mode
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
# Set hyprland cursor
hyprctl setcursor Simp1e-Tokyo-Night-Light 24
