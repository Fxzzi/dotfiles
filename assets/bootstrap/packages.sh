#!/usr/bin/env sh

packages=(
bottom
dunst
exa
kitty
macchina
mpc
mpd
ncmpcpp
neovim
papirus-icon-theme
pavucontrol
qt6ct
ripgrep
rofi-lbonn-wayland-only-git
swaybg
ttf-jetbrains-mono-nerd
waybar-git
hyprland-nvidia-git
)

countdown=5  # Set the countdown time in seconds
echo "Starting update in $countdown seconds. Press any key to cancel."

# Start the countdown loop
for i in $(seq $countdown -1 1); do
    echo "$i..."
    read -t 1 -n 1 && exit 1  # Wait for a key press and exit if one is detected
done

# Run the update command
paru -Syu --needed "${packages[@]}"

echo ""
echo -e "\033[1;33mThere may be some packages that weren't installed that are still mentioned in configs.\033[0m"
echo -e "\033[1;33mThese packages like firefox, webcord, prismlauncher, etc were not included because I'd\033[0m"
echo -e "\033[1;33mlike to leave these larger packages to user choice.\033[0m"

