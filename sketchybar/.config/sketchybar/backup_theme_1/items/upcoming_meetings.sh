sketchybar --add item     upcoming right                           \
           --set upcoming update_freq=20                           \
                          updates=on                               \
                          icon=$CAL                                \
                          icon.color=$BLACK                        \
                          icon.font="$FONT:Bold:14.0"             \
                          icon.padding_left=10                      \
                          icon.padding_right=5                     \
                          label.color=$BLACK                       \
                          label.padding_left=5                     \
                          label.padding_right=10                    \
                          align=center                             \
                          script="python3 $PLUGIN_DIR/upcoming.py" \
                          background.color=0xffb8c0e0              \
                          background.padding_left=0              \
                          background.padding_right=32              \
                          background.height=26                     \
                          background.corner_radius=11              \
                          click_script="sketchybar -m --set upcoming popup.drawing=toggle"
