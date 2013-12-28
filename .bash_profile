[[ -r ~/.bashrc ]] && . ~/.bashrc

# Set prompt
green='\[\e[0;32m\]'
red='\[\e[0;31m\]'
reset='\[\e[0m\]'
export GIT_PS1_SHOWDIRTYSTATE=1
PS1="$red\u$reset@$green\h $reset\w $red\$(__git_ps1)\n$red\$$reset "

stty -ixon

export GREP_OPTIONS='--color=auto'

#ALIAS
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ll -A'
alias gs='git status'

export VISUAL=vi
export EDITOR=$VISUAL
