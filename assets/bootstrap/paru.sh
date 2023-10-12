#!/usr/bin/env sh

if command -v paru >/dev/null 2>&1; then
	echo "paru is already installed"
else
	echo "Installing paru..."
	sudo pacman -Syu --needed base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru || exit 1
	makepkg -si
	cd ..
	rm -rf paru
fi
