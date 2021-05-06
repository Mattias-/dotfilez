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

# Set prompt
#reset=$(tput sgr0)
#red=$(tput setaf 1)
#yellow=$(tput setaf 3)
#blue=$(tput setaf 4)
#prompt_start="\[$yellow\]\u\[$reset\] @ "
#prompt_start+="\[$blue\]\h\[$reset\] \w"
#prompt_end="\n\[$red\]\\\$\[$reset\] "
#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWCOLORHINTS=1
#export GIT_PS1_SHOWUPSTREAM="auto verbose"

#function aws_account_info() {
#    [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo " (${yellow}${AWS_ACCOUNT_ROLE}${reset} @ ${blue}${AWS_ACCOUNT_NAME}${reset})"
#    [ "$AWS_PROFILE" ] && echo " (${yellow}${AWS_PROFILE}${reset})"
#}
#
#if [ -f /usr/share/git/completion/git-prompt.sh ]; then
#    source /usr/share/git/completion/git-prompt.sh
#fi
#PROMPT_COMMAND='__git_ps1 "$prompt_start" "$(aws_account_info)$prompt_end"'

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
    source /usr/share/nvm/nvm.sh --no-use
fi

eval "$(starship init bash)"

# macOS
if [ -f /usr/local/opt/nvm/nvm.sh ]; then
    [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
    source /usr/local/opt/nvm/nvm.sh --no-use
fi

if [[ $OSTYPE =~ darwin* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi
