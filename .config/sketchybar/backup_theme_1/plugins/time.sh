#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

sketchybar --set $NAME icon="$CLOCK  $(date '+%a %d. %b')" label="$(date '+%H:%M')"
