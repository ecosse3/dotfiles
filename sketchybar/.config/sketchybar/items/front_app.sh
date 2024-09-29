#!/bin/bash

FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

yabai=(
  script="$PLUGIN_DIR/yabai.sh"
  updates=on
  drawing=off
  icon.font="$FONT:Bold:16.0"
  label.drawing=off
  icon.width=30
  icon=$YABAI_GRID
  icon.color=$ORANGE
  associated_display=active
)

front_app=(
  script="$PLUGIN_DIR/front_app.sh"
  icon.drawing=off
  label.color=$WHITE
  label.font="$FONT:Black:12.0"
  associated_display=active
)

sketchybar --add event window_focus                    \
           --add event windows_on_spaces               \
           --add item front_app left                   \
           --set front_app "${front_app[@]}"           \
           --subscribe front_app front_app_switched

