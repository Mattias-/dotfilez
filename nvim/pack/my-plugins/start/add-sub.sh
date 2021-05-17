#!/bin/bash

add_dir() {
    remote=$(git -C "$1" remote get-url --push origin)
    git submodule add "$remote" "$1"
}

find . -name .git | cut -d/ -f-2 | while read -r d; do
    echo "Dir: $d"
    git rm --cached "$d"
    add_dir "$d"
done
