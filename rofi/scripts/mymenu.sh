#!/bin/bash

prefix=""

scripts_path="~/.config/rofi/scripts"

printen () {
    echo "$prefix"$1
}

if [ "$#" -eq 0 ]; then
    printen "wallpapers"
    printen "power"
    printen "cplay"
    exit
fi

if [ "$1" = ">" ]; then 
    cmus-remote -u
fi

chosen="$(echo "$1" | sed "s/^$prefix//")"

case "$chosen" in
  "wallpapers")
     i3-msg "exec $scripts_path/wallpapers.sh" > /dev/null
     exit 
    ;;
  "power")
     i3-msg "exec $scripts_path/powermenu.sh" > /dev/null
      exit
    ;;
  "cplay")
     i3-msg "exec $scripts_path/playcmus.sh" > /dev/null
      exit
    ;;
    *) 
    ;;
esac

