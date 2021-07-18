#!/bin/bash
set -euo pipefail

dry_run=false
encrypt=true

restore_paths=(
    .ssh
    kp
    work
    projects
    .config/rclone
)

backup_paths=(
    background.png
    .config
    .aws
    .ssh
    kp
    projects
    screenshots
    bin
    dotfilez
    work
)

exclude_paths=(
    .config/spotify
    .config/VirtualBox
    .config/google-chrome
)

backup() {
    date=$(date -u "+%Y-%m-%d_%H-%M")
    dest="./backup-${date}"
    rsync_args=()

    if $dry_run; then
        rsync_args+=("--dry-run")
    fi

    for ep in ${exclude_paths[*]}; do
        rsync_args+=("--exclude=$ep")
    done

    rsync -av \
        "${rsync_args[@]}" \
        "${backup_paths[@]}" \
        "$dest"

    find "$dest" -type f -size +50M
    tar -czf "$dest.tar.gz" "$dest"
    if $encrypt; then
        gpg --output "$dest.tar.gz.gpg" --symmetric "$dest.tar.gz"
    fi
}

restore() {
    #gpg --decrypt "$1.tar.gz.gpg" | tar -xz
    for rp in ${restore_paths[*]}; do
        echo "cp -ri $1/$rp ~"
    done
    #cp -ri $1/.ssh ~
    #cp -ri $1/.aws ~
    #cp -ri $1/kp ~
    #cp -ri $1/work ~
    #cp -ri $1/projects ~
    #cp -ri $1/.config/rclone ./.config/
}

restore "$1"
