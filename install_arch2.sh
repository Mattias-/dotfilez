#!/bin/bash
set -euo pipefail

main() {
    pacman --noconfirm -Sy terminus-font
    setfont ter-p28n
    mkdir ./profiles
    curl -L -o ./profiles/my-archinstall.py https://raw.githubusercontent.com/Mattias-/dotfilez/master/my-archinstall.py
    cat <<EOF
Archinstall setup complete run:
python -m archinstall my-archinstall
EOF
}

main
