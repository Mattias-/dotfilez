#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
    SPOTIFY_ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string')
    SPOTIFY_TITLE=$(osascript -e 'tell application "Spotify" to name of current track as string')
else
    if pgrep spotify &>/dev/null; then
        eval "$(sp eval "$@")" &>/dev/null
    fi
fi

if [ "$SPOTIFY_ARTIST" != "" ] || [ "$SPOTIFY_SHOW_NAME" != "" ]; then
    echo " ${SPOTIFY_TITLE:0:40} • ${SPOTIFY_ARTIST:0:40}${SPOTIFY_SHOW_NAME:0:40}"
fi
