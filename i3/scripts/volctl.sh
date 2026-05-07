#!/bin/bash

MAX_VOL=100
MIN_VOL=0
AUDIO_DELTA=5

VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

set_volume() {
  local volume=$1
  if [[ $volume -gt $MAX_VOL ]]; then
    volume=$MAX_VOL
  elif [[ $volume -lt $MIN_VOL ]]; then
    volume=$MIN_VOL
  fi
  pactl set-sink-volume @DEFAULT_SINK@ ${volume}%
}

case $1 in
  "lower")
    VOL=$((VOL - $AUDIO_DELTA))
    set_volume $VOL
    ;;
  "raise")
    VOL=$((VOL + $AUDIO_DELTA))
    set_volume $VOL
    ;;
  "mute")
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
  *)
    echo "Invalid argument. Use 'lower', 'raise', or 'mute'."
    ;;
esac
