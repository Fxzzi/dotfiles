#!/usr/bin/env bash

xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 300 \
    '~/.scripts/lock.sh' \
    '' \
  --timer 300 \
    'systemctl suspend' \
    ''
