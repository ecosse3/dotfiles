#!/usr/bin/env bash

POPUP_CLICK_SCRIPT="sketchybar --set $NAME popup.drawing=toggle"

wifi_alias=(
	alias.color="$YELLOW"
	align=right
	background.padding_left=0
	background.padding_right=0
	click_script="$POPUP_CLICK_SCRIPT"
	icon.drawing=on
	icon.padding_right=-10
	script="$PLUGIN_DIR/wifi.sh"
	update_freq=1
  label.drawing=off
	label.padding_left=0
	label.padding_right=0
)

wifi_details=(
	background.corner_radius=12
	background.padding_left=5
	background.padding_right=10
	icon.background.height=2
	icon.background.y_offset=-12
	label.align=center
	click_script="sketchybar --set wifi.alias popup.drawing=off"
)

sketchybar --add alias  "Control Centre,WiFi" right                      \
           --rename     "Control Centre,WiFi" wifi.alias                 \
           --set        wifi.alias    "${wifi_alias[@]}"                 \
           --subscribe  wifi.alias    mouse.entered                      \
                                      mouse.exited                       \
                                      mouse.exited.global                \
                                                                         \
            --add       item          wifi.details popup.wifi.alias      \
            --set       wifi.details  "${wifi_details[@]}"
