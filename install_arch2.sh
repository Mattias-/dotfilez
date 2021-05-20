#!/bin/bash
set -euo pipefail

main() {
    pacman --noconfirm -Sy terminus-font
    setfont ter-p28n

    mkdir -p ./profiles
    # File will already exist if the repo is cloned
    if [ -f ./my-archinstall.py ]; then
        cp ./my-archinstall.py ./profiles/
    else
        curl -L -o ./profiles/my-archinstall.py https://raw.githubusercontent.com/Mattias-/dotfilez/master/my-archinstall.py
    fi

    python -m archinstall my-archinstall

    git clone --recurse-submodules https://github.com/Mattias-/dotfilez /mnt/home/mattias/dotfilez
    chmod -R 1000:1000 --reference=/mnt/home/mattias /mnt/home/mattias/dotfilez

    echo "FONT=ter-p28n" >/mnt/etc/vconsole.conf
}

main
