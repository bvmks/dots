#!/usr/bin/env fish

if pgrep -x wofi > /dev/null
    exit 0
else
    fuzzel 
    # wofi --show drun --lines 20
end
