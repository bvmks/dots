#!/bin/bash

export LC_ALL=C.UTF-8

placeholder=""
interval=1

MYPID=$$

cmd_toggle="kill -USR1 $MYPID"

_state=1

toggle() {
    if [ "$_state" = "1" ]; then 
        _state=0
    else
        _state=1
    fi
}

trap "toggle" USR1

while true; do
    if info=$(cmus-remote -Q 2>/dev/null); then
        status=$(echo "$info" | awk '/status / {print $2}')

        if [[ "$status" = "playing" || "$status" = "paused" || "$status" = "stopped" ]]; then
            title=$(cmus-remote -C "format_print %F" | sed -E 's/\.[^.]*$//')
            
            if [ "$status" = "stopped" ];then
                position="0"
                duration="0"
            else
                position=$(echo "$info" | awk '/position / {print $2}')
                duration=$(echo "$info" | awk '/duration / {print $2}')
            fi

            
            if [ -n "$title" ]; then
                if [ "$duration" -ge 0 ] 2>/dev/null; then
                    pos_minutes=$(printf "%02d" $((position / 60)))
                    pos_seconds=$(printf "%02d" $((position % 60)))
                    dur_minutes=$(printf "%02d" $((duration / 60)))
                    dur_seconds=$(printf "%02d" $((duration % 60)))

                    cur_pos="$pos_minutes:$pos_seconds"
                    total="$dur_minutes:$dur_seconds"
                fi

                if [ "$_state" = 1 ]; then
                    echo "%{A1:$cmd_toggle:}$cur_pos%{A} "
                else
                    echo "%{A1:$cmd_toggle:}$cur_pos / $total%{A}"
                fi

            else
                echo " "
            fi
        else
            echo "$placeholder"
        fi
    else
        echo "$placeholder"
    fi

    sleep "$interval"
done
