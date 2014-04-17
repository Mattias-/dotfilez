[[ -r ~/.bashrc ]] && . ~/.bashrc

# Set prompt
green='\[\e[0;32m\]'
red='\[\e[0;31m\]'
reset='\[\e[0m\]'
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="${SCREENTITLE}$red\u$reset@$green\h $reset\w $red\$(__git_ps1)\n$red\$$reset "

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

