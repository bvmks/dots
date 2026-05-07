#!/bin/bash

# Настройки
dir="$HOME/media/music"
cache_file="$HOME/.cache/cmus_library"

if ! pgrep -x "cmus" > /dev/null; then
    # notify-send "Cmus" "NO BITHCHES?"
    exit 1
fi

# if [[ ! -f "$cache_file" || "$dir" -nt "$cache_file" ]]; then
    cmus-remote -C "save $cache_file"
# fi

choice=$(cat "$cache_file" | sed "s/.*\///" | rofi -dmenu -i -p "Play:" -format s)

if [[ -n "$choice" ]]; then
    full_path=$dir/$choice
    
    if [[ -n "$full_path" ]]; then
        cmus-remote -q "$full_path"
        cmus-remote --next
        # notify-send "Cmus" "Playing: $choice"
    fi
fi
