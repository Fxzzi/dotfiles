# Set XDG Base Directory paths
export XDG_CONFIG_HOME="${HOME}/.config"          # User configuration files
export XDG_CACHE_HOME="${HOME}/.cache"            # User cache files
export XDG_DATA_HOME="${HOME}/.local/share"       # User data files
export XDG_STATE_HOME="${HOME}/.local/state"      # User state files

# Set other tool and configuration paths to clean up ~
export CARGO_HOME="$XDG_DATA_HOME"/cargo          # Rust's Cargo package manager
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv       # NVIDIA CUDA cache
export GNUPGHOME="$XDG_DATA_HOME"/gnupg           # GNU Privacy Guard home
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME}"/java # Java preferences
export ANDROID_HOME="$XDG_DATA_HOME"/android     # Android SDK home

# Set Zsh shell history file path
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# Add additional directories to PATH
export PATH=$PATH:~/.local/scripts:~/.local/bin:~/.local/share/cargo/bin

# Set sudo password prompt
export SUDO_PROMPT='[] Enter Password: '

# Set default editor
export EDITOR='lvim'

# execute Hyprland when in TTY1 only
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi

