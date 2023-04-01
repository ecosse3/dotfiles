#!/usr/bin/env sh

sketchybar --add item     battery right                   \
           --set battery  update_freq=10                  \
                          icon.color=$BLACK               \
                          icon.font="$FIRA:Bold:14.0"     \
                          icon.padding_left=5             \
                          icon.padding_right=0            \
                          label.color=$BLACK              \
                          label.padding_left=5            \
                          label.padding_right=5           \
                          width=80                        \
                          align=center                    \
                          script="$PLUGIN_DIR/battery.sh" \
                          background.color=0xffb8c0e0     \
                          background.padding_left=10       \
                          background.padding_right=8      \
                          background.height=26            \
                          background.corner_radius=11
