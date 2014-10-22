[[ -r ~/.bashrc ]] && . ~/.bashrc

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Set prompt
green="\e[0;32m"
red="\e[0;31m"
reset="\e[0m"

me=$(whoami)
userc1=$(hashmod $me 0 1)
userc2=$(hashmod $me 31 37)
usercolor="\e[${userc1};${userc2}m"
host=$(hostname)
hostc1=$(hashmod $host 0 1)
hostc2=$(hashmod $host 31 37)
hostcolor="\e[${hostc1};${hostc2}m"

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="${SCREENTITLE}$usercolor\u$reset@$hostcolor\h $reset\w $red\$(__git_ps1)\n$red\$$reset "

# Fancy screen titles
if [ $TERM == 'screen' ]; then
    SCREENTITLE='\[\ek\e\\\]\[\ek\W\e\\\]'
    export PS1=${SCREENTITLE}${PS1}
fi

stty -ixon
export VISUAL=vi
export EDITOR=$VISUAL

export GREP_OPTIONS='--color=auto'

#ALIAS
alias ls='ls --color=auto'
alias ll='ls -ltrh'
alias la='ll -A'
alias gs='git status'
# Ask before overwriting
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# The Matrix screensaver, like a true hacker
alias screensaver='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
