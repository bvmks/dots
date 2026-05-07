#!/bin/bash
export LC_ALL=C.UTF-8

placeholder=""
interval=0.4
precision=1

winsteps=1

# window_frate=1
winlen=23

_if_scroll=0
_winpos=0
_winlen="$winlen"
_ext_title=""
_scroll_len=0

# _winaccum=0

# _window_dur=$(echo "scale=$precision; 1 / $window_frate" | bc)

_last_title=""

# --- UTF-8 SAFE FUNCTIONS ---

strlen_utf() {
    local str="$1"
    echo -n "$str" | awk '{print length}'
}

substr_utf() {
    local str="$1"
    local start="$2"
    local len="$3"
    echo "$str" | awk -v s=$((start+1)) -v l=$len '{print substr($0, s, l)}'
}

pad_right_utf() {
    local str="$1"
    local width="$2"
    local len=$(strlen_utf "$str")
    if [ "$len" -lt "$width" ]; then
        printf "%s%*s" "$str" $((width - len)) ""
    else
        echo "$str"
    fi
}

# ---------------------------

while true; do
    if info=$(cmus-remote -Q 2>/dev/null); then
        status=$(echo "$info" | awk '/status / {print $2}')

        title=$(cmus-remote -C "format_print %F" | sed -E 's/\.[^.]*$//')

        if [ "$status" = "playing" ]; then

            if [[ "$title" != "$_last_title" ]]; then
                _winpos=0
                _last_title="$title"

                title_len=$(strlen_utf "$title")

                # if [ "$title_len" -gt "$winlen" ]; then
                    _if_scroll=1
                    _winpos=$winlen
                    _ext_title="$(printf "%*s" "$winlen" '')$title"
                    # _winlen=$winlen
                # else
                #     _if_scroll=0
                #     _ext_title="$title"
                #     _win="$title"
                #     # _winlen=$title_len
                # fi

                _scroll_len=$(strlen_utf "$_ext_title")
            fi

            if [ -n "$title" ]; then
                if ((_if_scroll)); then
                    cut=$(substr_utf "$_ext_title" "$_winpos" "$winlen")
                    window=$(pad_right_utf "$cut" "$_winlen")

                    # _winaccum=$(echo "scale=$precision;$_winaccum + $interval" | bc)

                    # steps=$(echo "scale=0; $_winaccum / $_window_dur" | bc)
                    _winpos=$(( (_winpos + winsteps) % _scroll_len ))
                    # _winaccum=$(echo "scale=$precision;$_winaccum - $steps * $_window_dur" | bc)
                else
                    window=$(pad_right_utf "$_ext_title" "$_winlen")
                fi
                echo "$window"
            else
                echo " "
            fi
        elif [[ "$status" = "paused" || "$status" = "stopped" ]]; then
            _winpos="$winlen"
            cut=$(substr_utf "$title" "0" "$winlen")
            window=$(pad_right_utf "$cut" "$winlen")
            echo "$window"
        else
            echo "$placeholder"
        fi
    else
        echo "$placeholder"
    fi

    sleep "$interval"
done
