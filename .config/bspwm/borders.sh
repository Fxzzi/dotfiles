#!/bin/sh
# Enable double borders
# Dependencies: chwb2 from wmutils/opt
#
# Yes, this is stolen from gk.
# Adapted by Fxzzi.

outer='0x1a1b26' # outer
focused='0x7aa2f7' # focused
unfocused='0x414868' # unfocused

trap 'bspc config border_width 0; kill -9 -$$' INT TERM

targets() {
 	case $1 in
		focused)    bspc query -N -n .local.focused.\!fullscreen;;
		unfocused)  bspc query -N -n .normal.\!focused.\!fullscreen
	esac | grep -iv "$v"
}

bspc config border_width 12

draw() { chwb2 -I "$inner" -O "$outer" -i "3" -o "8" $* |:; }

# initial draw, and then subscribe to events
{ echo; bspc subscribe node_geometry node_focus; } |
 	while read -r _; do
		[ "$v" ] || v='abcdefg'
		inner=$focused draw "$(targets focused)"
		inner=$unfocused draw "$(targets unfocused)"
	done
