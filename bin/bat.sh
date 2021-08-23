#!/bin/bash
set -euo pipefail
if [ "$(uname)" == "Darwin" ]; then
    pmset -g batt | tail -1 | cut -f2 | cut -d ';' -f1
else
    cat /sys/class/power_supply/BAT0/capacity
fi
