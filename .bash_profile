
# Add /usr/local/sbin to PATH as some homebrew things are there
export PATH="/usr/local/sbin:$PATH"

# Add user's bin to PATH
export PATH="$HOME/bin:$PATH"

# Source the ~/.functions file if there is one
if [ -r "$HOME/.functions" ] && [ -f "$HOME/.functions" ] ; then
    source "$HOME/.functions"
fi

# Add better tab completion
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi

# For virtualenvwrapper
if which virtualenvwrapper.sh > /dev/null ; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/projects
    source /usr/local/bin/virtualenvwrapper.sh
fi

export EDITOR="vi";
export VISUAL=$EDITOR

export GREP_OPTIONS="--color=auto"

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
PROMPT_COMMAND='__git_ps1 "$prompt_start" "$prompt_end"'

# Fancy titles in GNU Screen
if [[ $TERM =~ 'screen' || $TERMCAP =~ 'screen' ]]; then
    SCREENTITLE='\[\ek\e\\\]\[\ek\W\e\\\]'
    export PS1=${SCREENTITLE}${PS1}
fi

### ALIAS
alias gs='git status'
alias newscreen='screen -S $(basename $(pwd))'

if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

alias ls='ls ${colorflag}'
alias ll='ls -ltrh'
alias la='ll -A'

# Ask before overwriting
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

complete -C aws_completer aws
export FZF_DEFAULT_COMMAND='(git ls-tree -r --full-tree --name-only HEAD || ag -g "") 2> /dev/null'
