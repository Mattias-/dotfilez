#!/bin/bash
set -euo pipefail

dry_run=false
encrypt=true

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

restore() {
    gpg --decrypt "$1" | tar -xz
}
