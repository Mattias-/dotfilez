#!/bin/bash

# shellcheck disable=SC2034

pip_packages=(
    wheel
    neovim
    pynvim
    black
    yamllint
    pre-commit
    pipenv
    pip
)

npm_packages=(
    dockerfile-language-server-nodejs
    vscode-langservers-extracted
    pyright
    typescript-language-server
    typescript
)

go_packages=(
    github.com/mattn/efm-langserver@latest
    github.com/goreleaser/goreleaser@latest
    golang.org/x/tools/gopls@latest
    github.com/golangci/golangci-lint/cmd/golangci-lint@v1.42.0
    github.com/aquasecurity/tfsec/cmd/tfsec@latest
)

pacman_packages=(
    curl
    jq
    git
    vim
    bc
    go
    tmux
    bash-completion
    htop
    tree
    fzf
    unzip
    fuse2
    rclone
    pacman-contrib
    reflector
    neofetch
    ripgrep
    bat
    zip
    bpytop
    man-db
    neovim
    starship
    go-yq

    nmap
    traceroute
    whois
    dnsutils
    ufw
    openssh
    iperf3
    gnu-netcat
    inetutils

    python
    python-pip
    python-pipenv
    python2

    sway
    swayidle
    swaylock
    xorg-server-xwayland
    grim
    slurp
    wofi
    waybar
    wl-clipboard

    light
    pavucontrol
    bluez-utils
    pipewire
    pipewire-alsa
    pipewire-jack
    pipewire-media-session
    pipewire-pulse
    gst-plugin-pipewire
    libpulse

    shfmt
    helm
    github-cli
    terraform
    vagrant
    packer
    hub
    docker
    virtualbox
    virtualbox-host-modules-arch
    minikube

    keepassxc
    firefox
    transmission-qt
    alacritty
    kitty
    wireshark-qt
    ttf-inconsolata
    ttf-dejavu
    ttf-liberation
    ttf-roboto
    noto-fonts-emoji
)

aur_packages=(
    pikaur
    pipes.sh
    google-cloud-sdk
    cfssl
    ttf-font-awesome-4
    nerd-fonts-inconsolata
    aws-cli-v2-bin
    aws-session-manager-plugin
    fnm-bin

    google-chrome
    spotify-dev
    visual-studio-code-bin

    kubectl-bin
    kind-bin
    shellcheck-bin
)

uninstalled_aur_packages=(
    grc
    tfsec
)
