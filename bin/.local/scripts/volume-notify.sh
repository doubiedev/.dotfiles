#!/bin/bash

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')

ICON="🔊"
if pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes; then
  ICON="🔇"
fi

dunstify -r 2593 -u low "$ICON Volume: $VOLUME%" "$(seq -s "█" $((VOLUME / 5)) | sed 's/[0-9]//g')"

