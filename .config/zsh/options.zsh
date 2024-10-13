#!/usr/bin/env zsh

# history related opts.
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_save_no_dups

# Match files beginning with . without explicitly specifying the dot
setopt globdots

# Enable using cd command without explicitly using cd in command
setopt autocd

# Disable all beeps in zsh
unsetopt beep

# tells zsh to ignore case when completing commands or filenames.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
