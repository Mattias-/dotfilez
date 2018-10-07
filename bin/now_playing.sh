#!/bin/bash
eval "$(sp eval)" &>/dev/null
if [ "$SPOTIFY_ARTIST" != "" ]; then
    echo "♫ $SPOTIFY_ARTIST - $SPOTIFY_TITLE"
fi
