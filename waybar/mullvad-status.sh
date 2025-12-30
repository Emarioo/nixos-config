#!/usr/bin/env bash

STATE_FILE="/tmp/waybar-mullvad.state"
status="$(mullvad status 2>/dev/null)"

if echo "$status" | grep -q "^Connected"; then
    relay=$(echo "$status" | awk -F': +' '/Relay:/ {print $2}')
    location=$(echo "$status" | awk -F': +' '/Visible location/ {print $2}' | cut -d. -f1)

    rm -f "$STATE_FILE"

    echo "{\"text\":\"$location\",\"class\":\"connected\",\"tooltip\":\"Mullvad\n$relay\"}"
elif [ -f "$STATE_FILE" ]; then
    echo '{"text":"VPN connecting...","class":"connecting","tooltip":"Mullvad: Connecting…"}'
else
    echo '{"text":"VPN off","class":"disconnected","tooltip":"Mullvad: Disconnected"}'
fi
