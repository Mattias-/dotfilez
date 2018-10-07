#!/bin/bash
set -euo pipefail

if [ "$(uname)" == "Darwin" ]; then
    uptime | grep -o 'averages:.*' | cut -d' ' -f2-
else
    cut -d " " -f 1-3 /proc/loadavg
fi
