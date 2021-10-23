#!/usr/bin/env bash

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# lock the screen after 600 seconds` \
  --timer 600 \
    '~/dotfiles/.scripts/lock.sh' \
    '' \
  `# Finally, suspend 10 minutes after it locks` \
  --timer 600 \
    'systemctl suspend"' \
    ''
