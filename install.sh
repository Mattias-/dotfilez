#!/usr/bin/env bash
files=(.bashrc .bash_profile .gitconfig .screenrc .vimrc .vim bin .gitignore_global)
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
for file in "${files[@]}"
do
    ln -s  $SCRIPTPATH/$file ~/ 2> /dev/null 
    if [ $? -ne 0 ]; then
        mv ~/$file ~/$file.bak$(date +%F)
        echo "Renamed old $file to $file.bak$(date +%F)"
        ln -s  $SCRIPTPATH/$file ~/ 2> /dev/null 
    fi
done
