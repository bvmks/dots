#!/bin/bash

# Если запускается без параметров — просто отображаем значок
if [ "$1" != "click" ]; then
    echo " Run"
    exit 0
fi

# Запускаем dmenu (или rofi)
chosen=$(ls /usr/share/applications/*.desktop | \
    xargs -n1 basename | sed 's/\.desktop$//' | dmenu -i -p "Run:")

# Если что-то выбрали — запускаем
if [ -n "$chosen" ]; then
    gtk-launch "$chosen" 2>/dev/null &
fi
