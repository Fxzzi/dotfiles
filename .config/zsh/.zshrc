#!/usr/bin/env zsh

# Source ZSH configs
source ${ZDOTDIR}/options.zsh # Source zsh options
source ${ZDOTDIR}/aliases.zsh # Source zsh aliases
source ${ZDOTDIR}/functions.zsh # Source custom functions
source ${ZDOTDIR}/keybinds.zsh # Source zsh keybinds
source ${ZDOTDIR}/zgenom.zsh # Source zgenom for plugins
source ${ZDOTDIR}/keybinds-late.zsh # Source late load keybinds


autoload -Uz compinit
compinit -d $XDG_STATE_HOME/zsh/zcompdump-$ZSH_VERSION

PROMPT='%F{yellow}%3~%f $ '

# Run fetch script on zsh start
if [ -z $WAYLAND_DISPLAY ]; then
	fastfetch -l none
else
	fastfetch
fi
