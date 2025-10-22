#!/usr/bin/env fish

hyprctl dispatch focusmonitor 1
kitty &
sleep 1

hyprctl dispatch focusmonitor 0
discord &
sleep 1

hyprctl dispatch focusmonitor 1


