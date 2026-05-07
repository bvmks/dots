#!/bin/bash

dir="$HOME/media/wallpapers"
save_file="$HOME/.config/i3/curr_walpaper"

tmp_file=$(mktemp)

for img in "$dir"/*.{jpg,jpeg,png,gif}; do
    if [[ -f "$img" ]]; then
        echo "$(basename "$img")" >> "$tmp_file"
    fi
done

choice=$(rofi -dmenu -i -p "Select wallpaper:" -format s < "$tmp_file")

if [[ -n "$choice" ]]; then
    file="$dir/$choice"
    (echo "$file" > $save_file)
    feh --bg-fill "$file"
fi

rm "$tmp_file"
