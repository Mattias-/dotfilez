#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
    SPOTIFY_ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string')
    SPOTIFY_TITLE=$(osascript -e 'tell application "Spotify" to name of current track as string')
else
    eval "$(sp eval)" &>/dev/null
fi

if [ "$SPOTIFY_ARTIST" != "" ]; then
    echo " $SPOTIFY_TITLE • $SPOTIFY_ARTIST"
    #echo "♫ $SPOTIFY_TITLE - $SPOTIFY_ARTIST"
fi
