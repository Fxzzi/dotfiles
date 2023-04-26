#!/usr/bin/env zsh

# Source ZSH configs
source ${ZDOTDIR}/zgenom.zsh # Source zgenom for plugins
source ${ZDOTDIR}/options.zsh # Source zsh options
source ${ZDOTDIR}/compinit.zsh # Source completion conf
source ${ZDOTDIR}/keybinds.zsh # Source zsh keybinds
source ${ZDOTDIR}/aliases.zsh # Source zsh aliases
source ${ZDOTDIR}/conf.zsh # Source conf function

# Run fetch script on zsh start
macchina --theme fazzi
