#!/bin/bash
set -euo pipefail
if [ "$(uname)" == "Darwin" ]; then
    pmset -g batt | tail -1 | cut -f2 | cut -d ';' -f1
else
    upower -i "$(upower -e | grep BAT)" | grep percentage | awk '{ print $2 }'
fi
