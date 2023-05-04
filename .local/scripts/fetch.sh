#!/bin/sh

# Author: https://github.com/AlphaTechnolog
# Adapted by: https://github.com/Fxzzi
user="${USER}"
shell="$(basename "${SHELL}")"
distro=$(. /etc/os-release ; echo "$ID")
wm="${XDG_CURRENT_DESKTOP}"
kernel="$(uname -r | cut -d '-' -f1)"
packages="$(pacman -Q | wc -l)"
memory="$(free -m | awk 'NR==2{printf "%sMiB\n", $3, $2}')"

white='\033[37m'
cyan='\033[36m'
blue='\033[34m'
green='\033[32m'
purple='\033[35m'
bold='\033[1m'
end='\033[0m'

len () {
  echo "${@}" | wc -c
}

repeat_by_len () {
  local str=$1
  local char=$2
  local len=$(len "$str")
  local i=1

  while [ $i -lt $len ]; do
    printf "$char"
    i=$(expr $i + 1)
  done
}

printf '%b' "
${bold}${blue}       ██           ${end}${bold}${blue}${user}${cyan}@${blue}$(cat /etc/hostname)${end}
${bold}${blue}      ████          ${end}${green}$(repeat_by_len "${user}@$(cat /etc/hostname)" "─")
${bold}${blue}      ▀████         ${end}${bold}${blue}  ${white}os${green}  ${cyan}${distro}${end}
${bold}${blue}    ██▄ ████        ${end}${bold}${blue}  ${white}sh${green}  ${cyan}${shell}${end}
${bold}${blue}   ██████████       ${end}${bold}${blue}缾 ${white}wm${green}  ${cyan}${wm}${end}
${bold}${blue}  ████▀  ▀████      ${end}${bold}${blue}  ${white}kr${green}  ${cyan}${kernel}${end}
${bold}${blue} ████▀    ▀████     ${end}${bold}${blue}  ${white}pk${green}  ${cyan}${packages}${end}
${bold}${blue}▀▀▀          ▀▀▀    ${end}${bold}${blue}  ${white}mm${green}  ${cyan}${memory}${end}
"
