#!/usr/bin/env fish

function print_help
    echo "Usage: volumecontrol.fish -o [i|d|m]"
    echo "  -o i    increase volume"
    echo "  -o d    decrease volume"
    echo "  -o m    toggle mute"
    exit 1
end

set step 2.5      # %
set device @DEFAULT_AUDIO_SINK@

#get
function get_current_volume
    wpctl get-volume $device | string match -r '[0-9.]+'
end

#set with clamp
function set_volume_safe --argument new_volume
    if test $new_volume -gt 100
        set new_volume 100
    else if test $new_volume -lt 0
        set new_volume 0
    end
    wpctl set-volume $device (math "$new_volume / 100.0")
end

# argv
argparse 'o=' -- $argv
or print_help

switch $_flag_o
    case i
        set cur (get_current_volume)
        set new (math "round($cur * 100) + $step")
        set_volume_safe $new
    case d
        set cur (get_current_volume)
        set new (math "round($cur * 100) - $step")
        set_volume_safe $new
    case m
        wpctl set-mute $device toggle
    case '*'
        print_help
end

