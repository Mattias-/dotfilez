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
    chown -R --reference=/mnt/home/mattias /mnt/home/mattias/dotfilez

    echo "FONT=ter-p28n" >/mnt/etc/vconsole.conf

    ln -sf /run/systemd/resolve/stub-resolv.conf /mnt/etc/resolv.conf
    rm -f /mnt/etc/systemd/network/20-ethernet.network

    patch_boot_entries
}

patch_boot_entries() {
    find /boot/loader/entries/ -type f | while read -r entry_file; do
        cat "$entry_file"
        new=$(sed -r 's/options (.*)/options \1 quiet/g' "$entry_file")
        diff --color "$entry_file" <(echo "$new")
        #echo "$new" >"$entry_file"
        #cat "$entry_file"
    done
}

main
