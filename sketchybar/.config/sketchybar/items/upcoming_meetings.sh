#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

sketchybar --add item     upcoming right                                                      \
           --set upcoming update_freq=20                                                      \
                          updates=on                                                          \
                          label.padding_left=0                                                 \
                          label.padding_right=10                                              \
                          align=center                                                        \
                          script="python3 $PLUGIN_DIR/upcoming.py"                            \
                          popup.background.height=26                                          \
                          popup.background.corner_radius=9                                    \
                          popup.background.border_width=1                                     \
                          popup.background.border_color=$POPUP_BORDER_COLOR                   \
                          popup.background.color=$POPUP_BACKGROUND_COLOR                      \
                          blur_radius=20                                                      \
                          background.shadow.drawing=on                                        \
                          click_script="sketchybar -m --set upcoming popup.drawing=toggle"
