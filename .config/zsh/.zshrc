#!/usr/bin/env zsh

# Source ZSH configs
source ${ZDOTDIR}/options.zsh # Source zsh options
source ${ZDOTDIR}/compinit.zsh # Source completion conf
source ${ZDOTDIR}/aliases.zsh # Source zsh aliases
source ${ZDOTDIR}/keybinds.zsh # Source zsh keybinds
source ${ZDOTDIR}/conf.zsh # Source conf function
source ${ZDOTDIR}/zgenom.zsh # Source zgenom for plugins

# Run fetch script on zsh start
macchina --theme fazzi
