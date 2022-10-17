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
  zgenom load clarketm/zsh-completions
  # generate the init script from plugins above
  zgenom save
fi

# GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
# e.g. cd <TAB> will now show files beginning with . 
setopt globdots

# Source aliases
source $HOME/.config/zsh/.aliases

# Run fetch script on zsh start
$HOME/.local/scripts/fetch.sh
