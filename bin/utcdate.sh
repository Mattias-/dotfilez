#!/bin/bash
set -euo pipefail

if [ "$(uname)" == "Darwin" ]; then
    date -u +"%H:%M %Z"
else
    date --utc +"%H:%M %Z"
fi
