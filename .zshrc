#!/bin/zsh
# shellcheck shell=bash

autoload -Uz compinit promptinit
compinit
promptinit

export EDITOR="vi"
export VISUAL=$EDITOR

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export GOPATH=$HOME/go

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export FZF_DEFAULT_COMMAND="rg --files --hidden --iglob '!.git/'"

if [ -r "$HOME/.functions" ] && [ -f "$HOME/.functions" ]; then
    source "$HOME/.functions"
fi
if [ -r "$HOME/.aliases" ] && [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi
if [ -r "$HOME/.workaliases" ] && [ -f "$HOME/.workaliases" ]; then
    source "$HOME/.workaliases"
fi

eval "$(starship init zsh)"
