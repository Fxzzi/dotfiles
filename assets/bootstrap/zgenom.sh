#!/usr/bin/env sh

if [ ! -r $ZDOTDIR/zgenom.zsh ]; then
  echo "Installing zgenom to: ${ZDOTDIR}..."
  git clone https://github.com/jandamm/zgenom.git $ZDOTDIR
else
  echo "zgenom is already installed"
fi
