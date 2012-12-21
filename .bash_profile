#[ -f /etc/bashrc ] && . /etc/bashrc

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

#ALIAS
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ll -A'

alias cdtests='cd /home/nicira/nox/src/nox/ext/testing/build_tests'
