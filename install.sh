#!/usr/bin/env bash
files=(.bashrc .bash_profile .gitconfig .screenrc .vimrc .vim)
for file in "${files[@]}"
do
    ln -s  $(dirname $0)/$file ~/ 2> /dev/null 
    if [ $? -ne 0 ]; then
        mv ~/$file ~/$file.bak$(date +%F)
        echo "Renamed old $file to $file.bak$(date +%F)"
        ln -s  $(dirname $0)/$file ~/ 2> /dev/null 
    fi
done
