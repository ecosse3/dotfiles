#!/usr/bin/env bash

bluetooth_alias=(
	alias.color="$PEACH"
	align=right
	background.padding_right=0
	click_script="$PLUGIN_DIR/bluetooth_click.sh"
	icon.drawing=off
	popup.height=30
	script="$PLUGIN_DIR/bluetooth.sh"
	update_freq=1
  icon.padding_right=0
  icon.padding_left=0
  label.drawing=off
)

bluetooth_details=(
	background.corner_radius=12
	background.padding_left=5
	background.padding_right=10
)

sketchybar --add alias  "Control Centre,Bluetooth" right                                    \
           --rename     "Control Centre,Bluetooth" bluetooth.alias                          \
           --set        bluetooth.alias  "${bluetooth_alias[@]}"                            \
           --subscribe  bluetooth.alias  mouse.entered                                      \
                                         mouse.exited                                       \
                                         mouse.exited.global                                \
                                                                                            \
            --add       item              bluetooth.details popup.bluetooth.alias           \
            --set       bluetooth.details "${bluetooth_details[@]}"                         \
            click_script="sketchybar --set bluetooth.alias popup.drawing=off"
