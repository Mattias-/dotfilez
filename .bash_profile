#!/bin/bash

export EDITOR="vi"
export VISUAL=${EDITOR}
export MANPAGER="nvim +Man!"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Unbind stupid bindings
stty -ixon -ixoff

export PATH=/usr/local/sbin:${PATH}
export PATH=${HOME}/bin:${HOME}/.local/bin:${PATH}

export GOPATH=${HOME}/go
export PATH=${GOPATH}/bin:${PATH}
export PATH=${PATH}:/usr/local/go/bin

# shellcheck disable=SC2154
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

export FZF_DEFAULT_COMMAND="rg --files --hidden --iglob '!.git/'"

if [ -r "${HOME}/.functions" ] && [ -f "${HOME}/.functions" ]; then
    # shellcheck disable=SC1090,SC1091
    source "${HOME}/.functions"
fi
if [ -r "${HOME}/.aliases" ] && [ -f "${HOME}/.aliases" ]; then
    # shellcheck disable=SC1090,SC1091
    source "${HOME}/.aliases"
fi
if [ -r "${HOME}/.workaliases" ] && [ -f "${HOME}/.workaliases" ]; then
    # shellcheck disable=SC1090,SC1091
    source "${HOME}/.workaliases"
fi

# Add better tab completion
if command -v brew &>/dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    # shellcheck disable=SC1090,SC1091
    source "$(brew --prefix)/etc/bash_completion"
fi
if [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    source /etc/bash_completion
fi
if [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck disable=SC1091
    source /usr/share/bash-completion/bash_completion
fi
complete -C aws_completer aws

if [[ ${OSTYPE} =~ darwin* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

eval "$(fnm env --shell bash)"
eval "$(starship init bash)"
