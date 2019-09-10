#!/bin/bash
set -euo pipefail

swaymsg --type get_inputs --raw |
    jq -r '[.[] |
    select(.type == "keyboard")] |
    first |
    .xkb_active_layout_name'
