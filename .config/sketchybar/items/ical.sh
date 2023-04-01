#!/usr/bin/env bash

POPUP_CLICK_SCRIPT="sketchybar --set ical popup.drawing=toggle"

ical=(
	update_freq=180
	icon=􀉉
  icon.padding_right=-6
  icon.padding_left=0
	icon.align=right
	popup.align=left
	popup.height=20
	background.padding_right=0
	background.padding_left=0
	y_offset=-1
	script="$PLUGIN_DIR/ical.sh"
	click_script="$POPUP_CLICK_SCRIPT"
)

ical_details=(
	drawing=off
	background.corner_radius=12
	padding_left=5
	padding_right=5
	icon.font="$FONT:Bold:14.0"
	icon.background.height=2
	icon.background.y_offset=-12
)

sketchybar  --add       item            ical right                            \
            --set       ical            "${ical[@]}"                          \
                                                                              \
            --add       item            ical.details popup.ical               \
            --set       ical.details    "${ical_details[@]}"                  \
            --subscribe ical            mouse.entered                         \
                                        mouse.exited                          \
                                        mouse.exited.global
