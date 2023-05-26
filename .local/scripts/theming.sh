#!/usr/bin/env sh

# Set the GTK theme to TokyoNight
gsettings set org.gnome.desktop.interface gtk-theme TokyoNight
# Set the icon theme to Papirus-Dark
gsettings set org.gnome.desktop.interface icon-theme Vimix-dark
# Set the default font to SF Pro Text at size 11
gsettings set org.gnome.desktop.interface font-name 'SF Pro Text 11'
# Set the cursor theme to S1mple and its size to 24
gsettings set org.gnome.desktop.interface cursor-theme S1mple
gsettings set org.gnome.desktop.interface cursor-size 24
# Set font antialiasing to subpixel rendering
gsettings set org.gnome.desktop.interface font-antialiasing rgba
# Set font rendering order to blue-green-red
gsettings set org.gnome.desktop.interface font-rgba-order bgr
# Set font hinting to slight
gsettings set org.gnome.desktop.interface font-hinting slight
# Set preferred theme to dark mode
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
# Set hyprland cursor
hyprctl setcursor Simp1e 24
