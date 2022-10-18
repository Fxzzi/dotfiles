# load zgenom
source "${ZDOTDIR}/.zgenom/zgenom.zsh"

# check for plugin and zgenom updates every 7 days
# this does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then

  # specify plugins here
  zgenom ohmyzsh
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh themes/robbyrussell

  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load MichaelAquilina/zsh-you-should-use
  zgenom load clarketm/zsh-completions
  # generate the init script from plugins above
  zgenom save
fi

# GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
# e.g. cd <TAB> will now show files beginning with . 
setopt globdots

# Remove superfluous blanks from each command line being added to the history list
setopt histreduceblanks

# Do not enter command lines into the history list if they are duplicates of the
# previous event.
setopt histignorealldups

# Append to history file after each command is run, and not when exiting shell.
# This means that the history of one terminal can be shared across terminal.
# Also enabled refreshing of history every time so it doesn't miss anything.
setopt sharehistory

# Bind keys for history substring search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Source aliases
source $HOME/.config/zsh/.aliases

# Run fetch script on zsh start
$HOME/.local/scripts/fetch.sh
