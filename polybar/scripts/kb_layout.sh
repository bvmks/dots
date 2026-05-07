#!/bin/bash

prnt() {
    CAPS=$(xset q | grep "Caps Lock" | awk '{print $4}')

    A=${1:0:1}
    A=${A^^}
    B=${1:1}         
    if [[ "$CAPS" == "on" ]]; then
        B=${B^^}
    fi

    OUT=$A$B
    echo $OUT
}

lang=$(xkb-switch)
if [[ "$lang" == "us" ]]; then
    lang="en"
fi

prnt $lang
