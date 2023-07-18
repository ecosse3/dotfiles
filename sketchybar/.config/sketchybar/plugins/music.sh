#!/bin/bash

next ()
{
  osascript -e 'tell application "Music" to play next track'
}

back () 
{
  osascript -e 'tell application "Music" to play previous track'
}

play () 
{
  osascript -e 'tell application "Music" to playpause'
}

repeat () 
{
  REPEAT=$(osascript -e 'tell application "Music" to get repeating')
  if [ "$REPEAT" = "false" ]; then
    sketchybar -m --set music.repeat icon.highlight=on
    osascript -e 'tell application "Music" to set repeating to true'
  else 
    sketchybar -m --set music.repeat icon.highlight=off
    osascript -e 'tell application "Music" to set repeating to false'
  fi
}

shuffle () 
{
  SHUFFLE=$(osascript -e 'tell application "Music" to get shuffling')
  if [ "$SHUFFLE" = "false" ]; then
    sketchybar -m --set music.shuffle icon.highlight=on
    osascript -e 'tell application "Music" to set shuffling to true'
  else 
    sketchybar -m --set music.shuffle icon.highlight=off
    osascript -e 'tell application "Music" to set shuffling to false'
  fi
}

update ()
{
  PLAYING=1
  if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
    PLAYING=0
    TRACK="$(echo "$INFO" | jq -r .Name | sed 's/\(.\{20\}\).*/\1.../')"
    ARTIST="$(echo "$INFO" | jq -r .Artist | sed 's/\(.\{20\}\).*/\1.../')"
    ALBUM="$(echo "$INFO" | jq -r .Album | sed 's/\(.\{25\}\).*/\1.../')"
    SHUFFLE=$(osascript -e 'tell application "Music" to get shuffling')
    REPEAT=$(osascript -e 'tell application "Music" to get repeating')
    COVER=$(osascript -e 'tell application "Music" to get artwork url of current track')
  fi

  args=()
  if [ $PLAYING -eq 0 ]; then
    curl -s --max-time 20 "$COVER" -o /tmp/cover.jpg
    if [ "$ARTIST" == "" ]; then
      args+=(--set music.title label="$TRACK"
             --set music.album label="Podcast"
             --set music.artist label="$ALBUM"  )
    else
      args+=(--set music.title label="$TRACK"
             --set music.album label="$ALBUM"
             --set music.artist label="$ARTIST")
    fi
    args+=(--set music.play icon=􀊆
           --set music.shuffle icon.highlight=$SHUFFLE
           --set music.repeat icon.highlight=$REPEAT
           --set music.cover background.image="/tmp/cover.jpg"
                               background.color=0x00000000
           --set music.anchor drawing=on                      )
  else
    args+=(--set music.anchor drawing=off popup.drawing=off
           --set music.play icon=􀊄                         )
  fi
  sketchybar -m "${args[@]}"
}

scrubbing() {
  DURATION_MS=$(osascript -e 'tell application "Music" to get duration of current track')
  DURATION=$((DURATION_MS/1000))

  TARGET=$((DURATION*PERCENTAGE/100))
  osascript -e "tell application \"Music\" to set player position to $TARGET"
  sketchybar --set music.state slider.percentage=$PERCENTAGE
}

scroll() {
  DURATION_MS=$(osascript -e 'tell application "Music" to get duration of current track')
  DURATION=$((DURATION_MS/1000))

  FLOAT="$(osascript -e 'tell application "Music" to get player position')"
  TIME=${FLOAT%.*}
  
  sketchybar --animate linear 10 \
             --set music.state slider.percentage="$((TIME*100/DURATION))" \
                                 icon="$(date -r $TIME +'%M:%S')" \
                                 label="$(date -r $DURATION +'%M:%S')"
}

mouse_clicked () {
  case "$NAME" in
    "music.next") next
    ;;
    "music.back") back
    ;;
    "music.play") play
    ;;
    "music.shuffle") shuffle
    ;;
    "music.repeat") repeat
    ;;
    "music.state") scrubbing
    ;;
    *) exit
    ;;
  esac
}

popup () {
  sketchybar --set music.anchor popup.drawing=$1
}

routine() {
  case "$NAME" in
    "music.state") scroll
    ;;
    *) update
    ;;
  esac
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "mouse.entered") popup on
  ;;
  "mouse.exited"|"mouse.exited.global") popup off
  ;;
  "routine") routine
  ;;
  "forced") exit 0
  ;;
  *) update
  ;;
esac
