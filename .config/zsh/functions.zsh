#!/usr/bin/env zsh

conf() {
  case $1 in
    hypr)     $EDITOR "$XDG_CONFIG_HOME/hypr/hyprland.conf" ;;
    waybar)   $EDITOR "$XDG_CONFIG_HOME/waybar/config" ;;
    dunst)    $EDITOR "$XDG_CONFIG_HOME/dunst/dunstrc" ;;
    rofi)     $EDITOR "$XDG_CONFIG_HOME/rofi/config.rasi" ;;
    kitty)    $EDITOR "$XDG_CONFIG_HOME/kitty/kitty.conf" ;;
    zsh)      $EDITOR "$XDG_CONFIG_HOME/zsh/.zshrc" ;;
    zprofile) $EDITOR "$XDG_CONFIG_HOME/zsh/.zprofile" ;;
    zaliases)  $EDITOR "$XDG_CONFIG_HOME/zsh/aliases.zsh" ;;
    zbinds)  $EDITOR "$XDG_CONFIG_HOME/zsh/keybinds.zsh" ;;
    zlatebinds) $EDITOR "$XDG_CONFIG_HOME/zsh/keybinds-late.zsh" ;;
    zopt)  $EDITOR "$XDG_CONFIG_HOME/zsh/options.zsh" ;;
    zgenom)  $EDITOR "$XDG_CONFIG_HOME/zsh/zgenom.zsh" ;;
    zcomp)  $EDITOR "$XDG_CONFIG_HOME/zsh/compinit.zsh" ;;
    zfunc)  $EDITOR "$XDG_CONFIG_HOME/zsh/functions.zsh" ;;
  esac
}
