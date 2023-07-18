#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:19.0"
  padding_right=5
  padding_left=0
  label.drawing=on
  update_freq=10
  updates=on
)

battery_details=(
	background.corner_radius=12
	background.padding_left=5
	background.padding_right=10
	icon.background.height=2
	icon.background.y_offset=-12
)

sketchybar --add item battery right                                          \
           --set battery "${battery[@]}"                                     \
           --subscribe   battery           mouse.entered                     \
                                           mouse.exited                      \
                                           mouse.exited.global               \
                                                                             \
           --add         item              battery.details popup.battery     \
           --set         battery.details   "${battery_details[@]}"
