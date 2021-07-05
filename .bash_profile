#!/bin/bash

# Add /usr/local/sbin to PATH as some homebrew things are there
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

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

# Add better tab completion
if command -v brew &>/dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    # shellcheck disable=SC1090
    source "$(brew --prefix)/etc/bash_completion"
fi
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi
if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

export EDITOR="vi"
export VISUAL=$EDITOR
export MANPAGER="nvim -c 'set ft=man' -"

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

# Fancy titles in GNU Screen
if [[ $TERM =~ 'screen' || $TERMCAP =~ 'screen' ]]; then
    SCREENTITLE='\[\ek\e\\\]\[\ek\W\e\\\]'
    export PS1=${SCREENTITLE}${PS1}
fi

complete -C aws_completer aws
export FZF_DEFAULT_COMMAND="rg --files --hidden --iglob '!.git/'"

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [ -f /usr/share/nvm/nvm.sh ]; then
    #source /usr/share/nvm/init-nvm.sh
    [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
    #source /usr/share/nvm/nvm.sh --no-use
    source /usr/share/nvm/nvm.sh use --lts
fi

eval "$(starship init bash)"

# macOS
if [ -f /usr/local/opt/nvm/nvm.sh ]; then
    [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
    #source /usr/local/opt/nvm/nvm.sh --no-use
    source /usr/share/nvm/nvm.sh use --lts
fi

if [[ $OSTYPE =~ darwin* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi
