#!/bin/bash
set -euo pipefail

dry_run=false

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
)

exclude_paths=(
    .config/spotify
    .config/VirtualBox
    .config/google-chrome
)

dest="./backup-$(date --iso-8601)"
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
