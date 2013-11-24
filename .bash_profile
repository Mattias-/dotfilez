[[ -r ~/.bashrc ]] && . ~/.bashrc

green='\[\e[0;32m\]'
redbold='\[\e[1;31m\]'
black='\[\e[0;30m\]'
red='\[\e[0;31m\]'
reset='\[\e[0m\]'
whitebk='\[\e[47m\]'
whitebold='\[\e[1;37m\]'
PS1="$redbold\u$green@\h $black$whitebk\w\n$red\$$reset "

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

stty -ixon

#ALIAS
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ll -A'

alias gs='git status -s'

export VISUAL=vi
export EDITOR=$VISUAL
