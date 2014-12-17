
# Add user's bin to PATH
export PATH="$HOME/bin:$PATH"

# Source the ~/.functions file if there is one
if [ -r "$HOME/.functions" ] && [ -f "$HOME/.functions" ] ; then
    source "$HOME/.functions"
fi

# Add better tab completion
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

export EDITOR="vi";
export VISUAL=$EDITOR

export GREP_OPTIONS="--color=auto"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Unbind stupid bindings
stty -ixon -ixoff

# Set prompt
green="\e[0;32m"
red="\e[0;31m"
reset="\e[0m"
uc=$(hash2color $(whoami))
hc=$(hash2color $(hostname))
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="$uc\u$reset@$hc\h $reset\w $red\$(__git_ps1)\n$red\$$reset "

# Fancy titles in GNU Screen
if [ $TERM == 'screen' ]; then
    SCREENTITLE='\[\ek\e\\\]\[\ek\W\e\\\]'
    export PS1=${SCREENTITLE}${PS1}
fi

### ALIAS
alias gs='git status'

alias ls='ls --color=auto'
alias ll='ls -ltrh'
alias la='ll -A'

# Ask before overwriting
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# The Matrix screensaver, like a true hacker
alias screensaver='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
