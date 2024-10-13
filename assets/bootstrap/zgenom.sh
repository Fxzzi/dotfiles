#!/usr/bin/env sh

ZDOTDIR="$HOME/.local/share/zgenom"

if [ -r "$ZDOTDIR"/.zgenom/zgenom.zsh ]; then
		echo "zgenom is already installed"
else
    echo "Installing zgenom to: ${ZDOTDIR}..."
    git clone https://github.com/jandamm/zgenom.git "$ZDOTDIR"/
fi
