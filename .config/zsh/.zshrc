#!/usr/bin/env zsh

source ${ZDOTDIR}/options.zsh # Source zsh options
source ${ZDOTDIR}/aliases.zsh # Source zsh aliases
source ${ZDOTDIR}/functions.zsh # Source custom functions
source ${ZDOTDIR}/keybinds.zsh # Source zsh keybinds

ZGENOMDIR="$XDG_DATA_HOME/zgenom"
if [ ! -d "$ZGENOMDIR" ]; then
	echo "Installing zgenom to: ${ZGENOMDIR}..."
	git clone https://github.com/jandamm/zgenom.git "$ZGENOMDIR"
fi

source ${ZDOTDIR}/zgenom.zsh # Source zgenom for plugins
source ${ZDOTDIR}/keybinds-late.zsh # Source late load keybinds

autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/.zcompdump

add-zsh-hook -Uz chpwd chpwd-osc7-pwd

PROMPT='%F{yellow}%3~%f $ '

# Run fetch script on zsh start
if [ -z $WAYLAND_DISPLAY ]; then
	fastfetch -l none
else
	fastfetch
fi
