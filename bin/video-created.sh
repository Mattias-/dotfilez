#!/bin/bash
set -euo pipefail

main() {
    if [ "$1" == "creation-date" ]; then
        creation_date "$2"
    elif [ "$1" == "touch-creation-date" ]; then
        touch_creation_date "$2"
    elif [ "$1" == "move-creation-date" ]; then
        move_creation_date "$2"
    elif [[ "$1" == "retouch" ]]; then
        retouch "$2"
    elif [[ "$1" == "move" ]]; then
        move "$2"
    else
        echo "No command specified"
        exit 1
    fi
}

creation_date() {
    ts=$(
        ffprobe -v quiet \
            -print_format json \
            -show_entries format_tags=creation_time \
            "$1" |
            jq -r '.format.tags.creation_time'
    )
    echo "$ts"
}

touch_creation_date() {
    # Remove -,T,: from formatted timestamp and take until minutes
    creation_date "$1" | tr -d '\-T:' | cut -c -12
}

move_creation_date() {
    creation_date "$1" | cut -c -10
}

retouch() {
    ts=$(touch_creation_date "$1")
    touch -t "$ts" "$1"
}

move() {
    ts=$(move_creation_date "$1")
    bn=$(basename "$1")
    dn=$(dirname "$1")
    mkdir -p "$dn/$ts"
    mv "$1" "$dn/$ts/$bn"
}

main "$@"
