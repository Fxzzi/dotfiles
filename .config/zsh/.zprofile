export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME}"/java
export ANDROID_HOME="$XDG_DATA_HOME"/android
export PNPM_HOME="/home/faaris/.local/share/pnpm"

export _JAVA_AWT_WM_NONREPARENTING=1
export __GL_SYNC_DISPLAY_DEVICE=DP-2
export VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=DP-2

export PATH=$PATH:$PNPM_HOME:~/.local/scripts:~/.local/bin:~/.local/share/cargo/bin
export EDITOR='lvim'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx "$XDG_CONFIG_HOME"/X11/xinitrc -- -keeptty >~/.local/share/xorg/Xorg.log 2>&1
fi
