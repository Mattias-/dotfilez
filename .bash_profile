#!/bin/bash

export HISTCONTROL=ignoreboth # ignoredups and ignorespace
shopt -s histappend           # Append to the history file, don't overwrite it
shopt -s checkwinsize         # Update the values of LINES and COLUMNS.
stty -ixon -ixoff             # Unbind stupid bindings

if [[ ${OSTYPE} =~ darwin* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi
# shellcheck disable=SC2154
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export EDITOR="vi"
export VISUAL=$EDITOR
export MANPAGER="nvim +Man!"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export FZF_DEFAULT_COMMAND="rg --files --hidden --iglob '!.git/'"
export GOPATH=$HOME/go
export NODE_PATH=$HOME/.npm-packages/lib/node_modules

if [ -d "$HOME/.nix-profile/share/man" ]; then
    export MANPATH=$HOME/.nix-profile/share/man:$MANPATH
fi

if [ -r /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH=${GOPATH}/bin:/usr/local/go/bin:${PATH}
export PATH=${HOME}/.npm-packages/bin:${PATH}
export PATH=${HOME}/bin:${HOME}/.local/bin:${PATH}

if command -v brew &>/dev/null; then
    for COMPLETION in "/opt/homebrew/etc/bash_completion.d/"*; do
        # shellcheck disable=1090
        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
fi

for COMPLETION in "$HOME/.nix-profile/share/bash-completion/completions/"*; do
    # shellcheck disable=1090
    [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
done

if [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    source /etc/bash_completion
fi
if [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck disable=SC1091
    source /usr/share/bash-completion/bash_completion
fi

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

eval "$(starship init bash)"
