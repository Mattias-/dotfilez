#!/bin/zsh
# shellcheck shell=bash

if [ -d "$(brew --prefix)/share/zsh/site-functions" ]; then
    export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

autoload -Uz compinit promptinit
compinit
promptinit

bindkey -e

export EDITOR="vi"
export VISUAL=$EDITOR
export MANPAGER="nvim +Man! -c ':set signcolumn='"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export GOPATH=$HOME/go

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export FZF_DEFAULT_COMMAND="rg --files --hidden --iglob '!.git/'"

if [ -r "$HOME/.functions" ] && [ -f "$HOME/.functions" ]; then
    # shellcheck disable=SC1090
    source "$HOME/.functions"
fi
if [ -r "$HOME/.aliases" ] && [ -f "$HOME/.aliases" ]; then
    # shellcheck disable=SC1090
    source "$HOME/.aliases"
fi
if [ -r "$HOME/.workaliases" ] && [ -f "$HOME/.workaliases" ]; then
    # shellcheck disable=SC1090
    source "$HOME/.workaliases"
fi

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
eval "$(fnm env --shell zsh)"
eval "$(starship init zsh)"
