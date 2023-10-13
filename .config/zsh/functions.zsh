#!/usr/bin/env zsh

conf() {
  case $1 in
    hypr)     $EDITOR "$XDG_CONFIG_HOME/hypr/hyprland.conf" ;;
    dunst)    $EDITOR "$XDG_CONFIG_HOME/dunst/dunstrc" ;;
    foot)    $EDITOR "$XDG_CONFIG_HOME/foot/foot.ini" ;;
  esac
}
