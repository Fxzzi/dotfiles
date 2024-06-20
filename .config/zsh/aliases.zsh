#!/usr/bin/env zsh

# Basic aliases
# alias rm='rm -rIv'   # Recursive, interactive, and verbose `rm`
# alias cp='cp -rv'   # Recursive and verbose `cp`
# alias mv='mv -v'    # Verbose `mv`
# alias mkdir='mkdir -p'  # recursive mkdir
alias grep='rg' # use ripgrep
alias cat='bat'

# `eza` aliases for more informative and colored output
alias la='eza --icons -a --group-directories-first'  # List all files and directories, including hidden ones
alias ll='eza --icons -lah --group-directories-first'  # List in long format with permissions and human-readable sizes
alias ls='eza --icons --group-directories-first'  # List files and directories

# `eza` alias for displaying directory trees
alias tree='eza --icons --tree'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit --verbose'
alias gcam='git commit --all --message'
alias gd='git diff'
alias gp='git push'

# Misc aliases
alias updates='checkupdates; paru -Qum'  # Check system and AUR updates
alias rs='curl --data-binary @- https://paste.rs | wl-copy'  # Share output to a pastebin and copy to clipboard
alias vim='$EDITOR'
alias vi='$EDITOR'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias uvolt="sudo bash -c 'source /root/nvidia-undervolt/bin/activate; python /root/nvidia-undervolt/undervolt.py'"
alias unvolt="sudo bash -c 'source /root/nvidia-undervolt/bin/activate; python /root/nvidia-undervolt/reset_uv.py'"
