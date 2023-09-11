#!/bin/zsh
# shellcheck shell=bash

bindkey -e

unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''

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
export MANPAGER="nvim +Man!"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export FZF_DEFAULT_COMMAND="rg --files --hidden --iglob '!.git/'"
export GOPATH=$HOME/go
export NODE_PATH=$HOME/.npm-packages/lib/node_modules
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"

if [ -r '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    # shellcheck disable=SC1091
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

if [ -d "$HOME/.nix-profile/share/man" ]; then
    manpath=("$HOME/.nix-profile/share/man" "${manpath[@]}")
fi

if [ -d "$HOME/.nix-profile/share/zsh/site-functions" ]; then
    fpath=("$HOME/.nix-profile/share/zsh/site-functions" "${fpath[@]}")
fi

if [ -d "/opt/homebrew/share/zsh/site-functions" ]; then
    fpath=("/opt/homebrew/share/zsh/site-functions" "${fpath[@]}")
fi

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

path=("$GOPATH/bin" "/usr/local/go/bin" "${path[@]}")
path=("$HOME/.npm-packages/bin" "${path[@]}")
path=("$HOME/bin" "$HOME/.local/bin" "${path[@]}")

if [ -r "$HOME/.functions" ]; then
    # shellcheck disable=SC1091
    source "$HOME/.functions"
fi
if [ -r "$HOME/.aliases" ]; then
    # shellcheck disable=SC1091
    source "$HOME/.aliases"
fi
if [ -r "$HOME/.workaliases" ]; then
    # shellcheck disable=SC1091
    source "$HOME/.workaliases"
fi

typeset -U path
typeset -U fpath
typeset -U manpath
autoload -Uz compinit
compinit
if [ -r "$HOME/.nix-profile/share/zsh/site-functions/aws_zsh_completer.sh" ]; then
    # shellcheck disable=SC1091
    source "$HOME/.nix-profile/share/zsh/site-functions/aws_zsh_completer.sh"
fi

eval "$(starship init zsh)"
