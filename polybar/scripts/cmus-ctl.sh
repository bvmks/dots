#!/bin/bash

interval=.5
placeholder=""
precision=1
MY_PID=$$

cmd_next="cmus-remote --next"
cmd_prev="cmus-remote --prev"
cmd_play="cmus-remote -u"
cmd_vol_dec="cmus-remote --volume -10%"
cmd_vol_inc="cmus-remote --volume +10%"

cmd_shuffle="cmus-remote -S"
cmd_repeat="cmus-remote -R"
cmd_contitue="cmus-remote -C \"toggle continue\""

cmd_aaa="kill -USR2 $MY_PID"

cmd_menu1="kill -USR1 $MY_PID"

menu_icon="~"

frate=1
icon_paused="|"
# play_anim=(">")
play_anim=("-" "\\" "|" "/")
fnum=${#play_anim[@]}

icon_next=">"
icon_prev="<"

_frame=0
_accum=0
_state=1
_fdur=$( echo "scale=$precision; 1 / $frate" | bc)

foreground="#C5C8C6"
color_active="$foreground"
color_disabled="#707880"
color_sep="#707880"

change_mod()
{
    info=$(cmus-remote -Q 2>/dev/null)
    repeat_cur=$(echo "$info" | awk '/set repeat_current / {print $3}')
    aaa=$(echo "$info" | awk '/set aaa_mode / {print $3}')

    if [ "$repeat_cur" = "true" ]; then
        cmus-remote -C "toggle repeat_current"
    elif [ "$aaa" = "all" ]; then
        cmus-remote -C "toggle repeat_current"
        cmus-remote -C "toggle aaa_mode"
    else
        cmus-remote -C "toggle aaa_mode"
    fi
}

toggle() 
{
    if [ "$_state" -ne "1" ]; then _state=1; else _state=0; fi
}

trap "toggle" USR1

trap "change_mod" USR2

while true; do
    if info=$(cmus-remote -Q 2>/dev/null); then
        status=$(echo "$info" | awk '/status / {print $2}')

        if [[ "$status" = "playing" \
            || "$status" = "paused" \
            || "$status" = "stopped" ]]; then
            vol=$(echo "$info" | awk '/set vol/ {print $3}' | tr -d '%' | head -n1)
            
            shuffle=$(echo "$info" | awk '/set shuffle / {print $3}')
            repeat=$(echo "$info" | awk '/set repeat / {print $3}')
            repeat_cur=$(echo "$info" | awk '/set repeat_current / {print $3}')
            cont=$(echo "$info" | awk '/set continue / {print $3}')

            aaa=$(echo "$info" | awk '/set aaa_mode / {print $3}')

            if [ "$status" = "playing" ]; then
                icon_play_pause="${play_anim[$_frame]}"
            else
                icon_play_pause="$icon_paused"
            fi

            case "$aaa" in
                all)      aaa_text="LIB" ;;
                album)    aaa_text="ALB" ;;
                artist)   aaa_text="ART" ;;
                *)        aaa_text="???" ;;
            esac
            
            if [ "$repeat_cur" = "true" ]; then
                aaa_text="RCUR"
            fi

            aaa_block="%{A1:$cmd_aaa:}$aaa_text%{A}"

            if [[ "$shuffle" = "tracks" ]]; then
                s_btn="%{F$color_active}S%{F-}"
            elif [ "$shuffle" = "albums" ]; then
                s_btn="%{F$color_active}&%{F-}"
            else
                s_btn="%{F$color_disabled}S%{F-}"
            fi
            shuffle_block="%{A1:$cmd_shuffle:}$s_btn%{A}"

            if [ "$repeat" = "true" ]; then
                r_btn="%{F$color_active}R%{F-}"
            else
                r_btn="%{F$color_disabled}R%{F-}"
            fi
            repeat_block="%{A1:$cmd_repeat:}$r_btn%{A}"


            if [ "$cont" = "true" ]; then
                c_btn="%{F$color_active}C%{F-}"
            else
                c_btn="%{F$color_disabled}C%{F-}"
            fi
            continue_block="%{A1:$cmd_contitue:}$c_btn%{A}"

            block_sep=" %{F$color_sep}|%{F-} "
            
            control_block="\
%{A1:$cmd_prev:}$icon_prev%{A}\
%{A1:$cmd_play:} $icon_play_pause %{A}\
%{A1:$cmd_next:}$icon_next%{A}\
"
            
            vol_block="\
%{A4:$cmd_vol_inc:}\
%{A5:$cmd_vol_dec:}$(printf "%3d%%" "$vol")\
%{A}%{A}\
"

            format_closed="%{A1:$cmd_menu1:}$menu_icon%{A} $control_block"
            
            format_opened="%{A3:$cmd_menu1:}\
%{A1:$cmd_menu1:}$menu_icon%{A}\
$block_sep\
$aaa_block\
$block_sep\
$vol_block\
$block_sep\
$continue_block \
$repeat_block\
$shuffle_block\
$block_sep\
$control_block\
%{A}\
"

            if [ "$_state" -eq 1 ]; then
                echo "$format_closed"
            else
                echo "$format_opened"
            fi
            _accum=$( echo "scale=$precision;$_accum + $interval" | bc )
            if (( $(echo "scale=$precision; $_accum > $_fdur" | bc -l) )); then
                _frame=$(( (_frame + 1) % fnum ))
                _accum=$( echo "scale=$precision;$_accum - $_fdur" | bc )
            fi
        else
            _state=1; echo "$placeholder"
        fi
    else
        _state=1; echo "$placeholder"
    fi

    sleep "$interval"
done



