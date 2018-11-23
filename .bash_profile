
# Add /usr/local/sbin to PATH as some homebrew things are there
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

if [ -r "$HOME/.functions" ] && [ -f "$HOME/.functions" ] ; then
    source "$HOME/.functions"
fi

if [ -r "$HOME/.aliases" ] && [ -f "$HOME/.aliases" ] ; then
    source "$HOME/.aliases"
fi

# Add better tab completion
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi

if which assume-role > /dev/null; then
    source $(which assume-role)
fi

# For virtualenvwrapper
if which virtualenvwrapper.sh > /dev/null ; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/projects
    source /usr/local/bin/virtualenvwrapper.sh
fi

export EDITOR="vi";
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
reset=$(tput sgr0)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
prompt_start="\[$yellow\]\u\[$reset\] @ "
prompt_start+="\[$blue\]\h\[$reset\] \w"
prompt_end="\n\[$red\]\\\$\[$reset\] "
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUPSTREAM="auto verbose"

function aws_account_info {
    [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo " (${yellow}${AWS_ACCOUNT_ROLE}${reset} @ ${blue}${AWS_ACCOUNT_NAME}${reset})"
}

PROMPT_COMMAND='__git_ps1 "$prompt_start" "$(aws_account_info)$prompt_end"'

# Fancy titles in GNU Screen
if [[ $TERM =~ 'screen' || $TERMCAP =~ 'screen' ]]; then
    SCREENTITLE='\[\ek\e\\\]\[\ek\W\e\\\]'
    export PS1=${SCREENTITLE}${PS1}
fi


complete -C aws_completer aws
export FZF_DEFAULT_COMMAND='(set -o pipefail; git ls-tree -r --full-tree --name-only HEAD | sed "s:^:$(git rev-parse --show-toplevel)/:" || ag -g "") 2> /dev/null'

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
