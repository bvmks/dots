#!/usr/bin/env fish 

if pgrep -x wofi > /dev/null 
    exit 0 
else 
    cliphist list | wofi --dmenu | cliphist decode | wl-copy 
end
