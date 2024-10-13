#!/usr/bin/env zsh

source "$XDG_DATA_HOME/zgenom/zgenom.zsh"

# check for plugin and zgenom updates every 7 days
# this does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
  # Enable fzf (fuzzy finder) for tab completions and history searching
  zgenom load Aloxaf/fzf-tab
  zgenom load joshskidmore/zsh-fzf-history-search
  # Enable syntax highlighting
  zgenom load zsh-users/zsh-syntax-highlighting
  # Enable useful zsh-users plugins
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load --completion zsh-users/zsh-completions

  # generate the init script from plugins above
  zgenom save
fi
