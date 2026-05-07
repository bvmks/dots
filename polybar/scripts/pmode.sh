#!/bin/bash
interval=1
MYPID=$$

cmd_toggle="kill -USR1 $MYPID"
cmd_ac="sudo tlp performance"
cmd_bat="sudo tlp balanced"
cmd_sav="sudo tlp power-saver"

icon_ac="P"
icon_bat="B"
icon_sav="S"

_state=1
toggle() { _state=$((1 - _state)); }
trap "toggle" USR1

while true; do
    pstate=$(tlp-stat -s 2> /dev/null | awk '/Power profile / {print $4}' | sed "s/.*\///")
    
    case "$pstate" in
        AC)  m_info="[$icon_ac]" ;;
        BAT) m_info="[$icon_bat]" ;;
        SAV) m_info="[$icon_sav]" ;;
        *)   m_info="[?]" ;;
    esac
    
    m_format_opened="[%{A1:$cmd_ac; $cmd_toggle:}$icon_ac%{A} %{A1:$cmd_bat; $cmd_toggle:}$icon_bat%{A} %{A1:$cmd_sav; $cmd_toggle:}$icon_sav%{A}]"

    if [ "$_state" = "1" ]; then
        echo "%{A1:$cmd_toggle:}$m_info%{A}"
    else
        echo "%{A1:$cmd_toggle:}$m_format_opened%{A}"
    fi

    sleep "$interval" & wait $!
done
