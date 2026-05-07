#!/bin/bash

save_file="$HOME/.config/i3/curr_walpaper"
dir="$HOME/media/wallpapers/"
defaul="$HOME/media/wallpapers/djang.png"

if [ -e "$save_file" ]; then
    curr_walpaper=$(cat "$save_file")
else
    (echo "$defaul" > $save_file)
    curr_walpaper="$defaul"
fi

feh --bg-fill $curr_walpaper
