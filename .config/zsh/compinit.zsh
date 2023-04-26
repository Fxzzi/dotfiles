#!/usr/bin/env zsh

# Don't use $ZDOTDIR for the completion dump
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
