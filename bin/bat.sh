#!/bin/bash
set -euo pipefail
if [ "$(uname)" == "Darwin" ]; then
    pmset -g batt | tail -1 | cut -f2 | cut -d ';' -f1
else
    if hash upower; then
        upower -i "$(upower -e | grep BAT)" | grep percentage | awk '{ print $2 }'
    else
        grep "POWER_SUPPLY_CAPACITY=" /sys/class/power_supply/BAT0/uevent | cut -d"=" -f2
    fi
fi
