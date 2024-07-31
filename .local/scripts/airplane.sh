#!/usr/bin/env sh

rfkill toggle all

if [ -z "$(rfkill -n | grep unblocked)" ]; then
    dunstify -a "airplane" -r "5997" -i "airplane-mode-symbolic" "Airplane mode" "Enabled"
else
    dunstify -a "airplane" -r "5997" -i "airplane-mode-disabled-symbolic" "Airplane mode" "Disabled"
fi

