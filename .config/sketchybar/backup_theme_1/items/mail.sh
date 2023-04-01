#!/usr/bin/env sh

sketchybar --add item mail right                   \
           --set mail update_freq=120              \
                      script="$PLUGIN_DIR/mail.sh" \
                      background.padding_left=0    \
                      background.padding_right=5   \
                      icon.font="$FONT:Bold:16.0"  \
                      icon=$MAIL                   \
                      icon.color=$WHITE            \
                      label=!
