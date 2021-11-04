#!/bin/zsh
# shellcheck shell=bash

if [ -d "/opt/homebrew/share/zsh/site-functions" ]; then
    export FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"
fi

unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''

autoload -Uz compinit
compinit

bindkey -e

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
# shellcheck disable=SC2034
SAVEHIST=10000
## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history

export EDITOR="vi"
export VISUAL=$EDITOR
export MANPAGER="nvim +Man! -c ':set signcolumn='"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export GOPATH=$HOME/go

path=("/usr/local/sbin" "${path[@]}")
path=("/usr/local/go/bin" "$GOPATH/bin" "${path[@]}")
path=("$HOME/.local/bin" "$HOME/bin" "${path[@]}")
path=("${KREW_ROOT:-$HOME/.krew}/bin" "${path[@]}")

typeset -U path

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
