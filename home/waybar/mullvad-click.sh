#!/usr/bin/env bash

STATE_FILE="/tmp/waybar-mullvad.state"

if [ "$1" == "off" ]; then
    rm -f "$STATE_FILE"
    mullvad disconnect
else
    echo "connecting" > "$STATE_FILE"
    mullvad connect
fi
