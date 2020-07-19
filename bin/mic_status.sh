#!/bin/bash
set -euo pipefail

if pactl list sources | grep 'Mute: yes' >/dev/null; then
    echo '{"text": "muted", "alt": "muted", "class":"muted"}'
else
    echo '{"text": "not-muted", "alt": "not-muted"}'
fi
