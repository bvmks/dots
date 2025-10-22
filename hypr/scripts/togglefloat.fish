#!/usr/bin/env fish

set argc (count $argv) 

set -l  winid (hyprctl activewindow -j | jq -r '.address')
test -z "$winid" && exit 1

set -l isfloat (hyprctl activewindow -j | jq -r '.floating')

if test "$isfloat" = "false"
    if test $argc -eq 0
        exit 1
    end
    hyprctl dispatch togglefloating address:"$winid"
    hyprctl dispatch resizewindowpixel exact $argv[1]% $argv[1]%, address:"$winid"
    hyprctl dispatch centerwindow address:"$winid"
else
        hyprctl dispatch togglefloating address:"$winid"
end

