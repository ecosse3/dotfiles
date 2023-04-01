#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

render_bar_item() {
  sketchybar --set "${NAME}" icon.color=0xff989898

  if [[ ${CHARGING} != "" ]]; then
      case ${BATT_PERCENT} in
          100) ICON="$BATTERY_CHARGING" COLOR="$GREEN" ;;
          9[0-9]) ICON="$BATTERY_CHARGING" COLOR="$GREEN" ;;
          8[0-9]) ICON="$BATTERY_CHARGING" COLOR="$GREEN" ;;
          7[0-9]) ICON="$BATTERY_CHARGING" COLOR="$GREEN" ;;
          6[0-9]) ICON="$BATTERY_CHARGING" COLOR="$YELLOW" ;;
          5[0-9]) ICON="$BATTERY_CHARGING" COLOR="$YELLOW" ;;
          4[0-9]) ICON="$BATTERY_CHARGING" COLOR="$PEACH" ;;
          3[0-9]) ICON="$BATTERY_CHARGING" COLOR="$PEACH" ;;
          2[0-9]) ICON="$BATTERY_CHARGING" COLOR="$RED" ;;
          1[0-9]) ICON="$BATTERY_CHARGING" COLOR="$RED" ;;
          *) ICON="$BATTERY_CHARGING"  COLOR="$RED" ;;
      esac

    sketchybar --set "${NAME}" icon="${ICON}" icon.color="${COLOR}"
    sketchybar --set "${NAME}" label="${BATT_PERCENT}%"
    
    low_battery_label 
    return 0
  fi

  case ${BATT_PERCENT} in
      100) ICON="$BATTERY_100" COLOR="$GREEN" ;;
      9[0-9]) ICON="$BATTERY_100" COLOR="$GREEN" ;;
      8[0-9]) ICON="$BATTERY_75" COLOR="$GREEN" ;;
      7[0-9]) ICON="$BATTERY_75" COLOR="$GREEN" ;;
      6[0-9]) ICON="$BATTERY_75" COLOR="$YELLOW" ;;
      5[0-9]) ICON="$BATTERY_50" COLOR="$YELLOW" ;;
      4[0-9]) ICON="$BATTERY_50" COLOR="$PEACH" ;;
      3[0-9]) ICON="$BATTERY_25" COLOR="$PEACH" ;;
      2[0-9]) ICON="$BATTERY_25" COLOR="$RED" ;;
      1[0-9]) ICON="$BATTERY_0" COLOR="$RED" ;;
      *) ICON="$BATTERY_0"  COLOR="$RED" ;;
  esac

  sketchybar --set "${NAME}" icon="${ICON}" icon.color="${COLOR}"

  low_battery_label 
}

low_battery_label() {
  if [[ "$BATT_PERCENT" -lt 50 ]]; then 
          sketchybar --set "${NAME}" label="${BATT_PERCENT}%" label.drawing=on
  else 
          sketchybar --set "${NAME}" label.drawing=off
  fi
}

render_popup() {
  args+=(--set  battery.details                                                           \
                              label="${BATT_PERCENT}%"                                    \
                              label.padding_right=0                                       \
                              label.padding_right=0                                       \
                              label.align=center \
                              click_script="sketchybar --set $NAME popup.drawing=off")

  sketchybar -m "${args[@]}" > /dev/null
}

update() {
  render_bar_item
  render_popup
}

popup() {
  if [[ "$BATT_PERCENT" -gt 50 ]]; then         
    sketchybar --set "$NAME" popup.drawing="$1"
  else 
    sketchybar --set "$NAME" popup.drawing=off
  fi
}

case "$SENDER" in
  "routine"|"forced") update
  ;;
  "mouse.entered") popup on
  ;;
  "mouse.exited"|"mouse.exited.global") popup off
  ;;
  "mouse.clicked") popup toggle
  ;;
esac
