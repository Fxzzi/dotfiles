export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME}"/java
export ANDROID_HOME="$XDG_DATA_HOME"/android

export HISTFILE="$XDG_STATE_HOME"/zsh/history

export PATH=$PATH:~/.local/scripts:~/.local/bin:~/.local/share/cargo/bin
export SUDO_PROMPT='[] Enter Password: '
export EDITOR='lvim'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi
