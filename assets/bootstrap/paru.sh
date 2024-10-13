#!/usr/bin/env sh

if command -v paru >/dev/null 2>&1; then
	echo "paru is already installed"
else
	echo "Installing paru..."
	sudo pacman -Syu --noconfirm --needed base-devel less git wget ccache
	git clone https://aur.archlinux.org/paru.git /tmp/paru.aur
	cd /tmp/paru.aur
	makepkg -si
	cd ..
fi
