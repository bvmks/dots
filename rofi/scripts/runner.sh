#!/bin/bash

mymenu1="utils:~/.config/rofi/scripts/mymenu.sh"

# rofi -show druw -modi "window,drun,$mymenu1"

rofi -show combi \
     -modi "$mymenu1,combi,ssh" \
     -combi-modi "drun,$mymenu1,window"
