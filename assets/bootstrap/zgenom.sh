#!/usr/bin/env sh

if [ ! -r $ZDOTDIR/.zgenom/zgenom.zsh ]; then
  echo "Installing zgenom to: ${ZDOTDIR}..."
  git clone https://github.com/jandamm/zgenom.git $ZDOTDIR/.zgenom
else
  echo "zgenom is already installed"
fi
