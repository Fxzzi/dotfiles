# load zgenom
source "${ZDOTDIR}/.zgenom/zgenom.zsh"

# check for plugin and zgenom updates every 7 days
# this does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then

  # specify plugins here
  zgenom ohmyzsh
  zgenom ohmyzsh themes/robbyrussell
  
  zgenom load mdumitru/git-aliases
  zgenom load zdharma-continuum/fast-syntax-highlighting
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load clarketm/zsh-completions
  zgenom load joshskidmore/zsh-fzf-history-search
  zgenom load Aloxaf/fzf-tab
  zgenom load akash329d/zsh-alias-finder

# generate the init script from plugins above
  zgenom save
fi

# GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
# e.g. cd <TAB> will now show files beginning with . 
setopt globdots

# Append to history file after each command is run, and not when exiting shell.
# This means that the history of one terminal can be shared across terminal.
# Also enabled refreshing of history every time so it doesn't miss anything.
setopt sharehistory

# Bind keys for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

# Source aliases
source $HOME/.config/zsh/.aliases

# Run fetch script on zsh start
#$HOME/.local/scripts/fetch.sh
env XDG_SESSION_TYPE=x11 macchina --theme fazzi
