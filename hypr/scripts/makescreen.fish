#!/usr/bin/env fish

if pgrep -x wofi > /dev/null
    exit 0
end

set has_arg 0
set fast_select 
set argc (count $argv)
if test $argc -ne 0
    set has_arg 1
    for i in (seq 1 $argc)
        if test $argv[$i] = "-m"
            if test $i -ne $argc
                switch $argv[(math $i+1)]
                    case "region"
                        set fast_select "region"
                    case "screen"
                        set fast_select "screen"
                    case '*'
                        exit 1
                end
            else
                exit 1
            end
        end
    end
end

set select ""
if test $has_arg -eq 0
    set select (printf "region\nwindow\nmonitor" | wofi --dmenu --prompt "Screenshot mode:")

    if test -z "$select"
        exit 1
    end
else
    set select $fast_select 
end

 
set screenshot_dir "$HOME/media/screenshots"
mkdir -p $screenshot_dir

set filename (date "%H-%M-%S").png
set filedir ( date "+%Y-%m-%d")
set filepath "$screenshot_dir/$filedir/$filename"

switch $select
    case "window"
        hyprshot -m window -i -o $filepath
    case "region"
        hyprshot -m region -o $filepath
    case "screen"
        hyprshot -m output -o $filepath
end

if test -f $filepath
    cat $filepath | wl-copy --type image/png
    notify-send "Screenshot" "Saved and copied to clipboard:\n$filename"
end

