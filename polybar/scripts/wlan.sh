#!/bin/bash
interval=1
interface="wlan0"
MYPID=$$

cmd_toggle="kill -USR1 $MYPID"

icon_no_net="-"
icon_wifi_on="@"

_state=1
toggle() { _state=$((1 - _state)); }
trap "toggle" USR1

while true; do
    wifi_name=$(iwconfig $interface 2>/dev/null | awk -F'"' '/ESSID/ {print $2}')

    if [ -z "$wifi_name" ] || [ "$wifi_name" = "off/any" ]; then 
        m_info="[$icon_no_net]"
        wifi_display="$interface: --"
    else
        m_info="[$icon_wifi_on]"
        wifi_display="$wifi_name"
    fi

    m_format_opened="[$wifi_display]"

    if [ "$_state" = "1" ]; then
        echo "%{A1:$cmd_toggle:}$m_info%{A}"
    else
        echo "%{A1:$cmd_toggle:}$m_format_opened%{A}"
    fi

    sleep "$interval" & wait $!
done
