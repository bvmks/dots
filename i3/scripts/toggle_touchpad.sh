#!/bin/bash

DEVICE="HTIX5288:00 36B6:C001 Touchpad"

STATUS=$(xinput list-props "$DEVICE" | grep "Device Enabled" | awk '{print $4}')

if [ "$STATUS" -eq 1 ]; then
    xinput disable "$DEVICE"
else
    xinput enable "$DEVICE"
fi
