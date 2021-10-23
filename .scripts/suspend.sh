#!/bin/bash

xautolock -time 10 -locker "/home/faaris/dotfiles/.scripts/lock.sh" -notifier 'notify-send "Screen locking in 30 seconds."' -notify 30 -corners +++- &
xautolock -time 20 -locker "systemctl suspend" -corners +++-
