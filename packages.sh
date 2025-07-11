#!/bin/bash

# shellcheck disable=SC2034

pip_packages=(
    black
    yamllint
    pre-commit
)

npm_packages=(
    dockerfile-language-server-nodejs
    vscode-langservers-extracted
    pyright
    typescript-language-server
    typescript
    bash-language-server
    yaml-language-server
    aws-cdk
    prettier
    rdme
    @redocly/cli@v1.6.0
    @stoplight/spectral-cli
    @quobix/vacuum
    pnpm@9.9.0
    @biomejs/biome
    @getgrit/cli
)

go_packages=(
    github.com/mattn/efm-langserver@latest
    github.com/goreleaser/goreleaser/v2@latest
    golang.org/x/tools/gopls@latest
    github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.0.2
    github.com/aquasecurity/tfsec/cmd/tfsec@latest
    github.com/swaggo/swag/cmd/swag@v1.8.7
    github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
    github.com/mrtazz/checkmake/cmd/checkmake@latest
    github.com/google/ko@latest
    github.com/bufbuild/buf/cmd/buf@v1.53.0
    github.com/sigstore/cosign/v2/cmd/cosign@latest
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
    pipewire-pulse
    wireplumber
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
    ttf-fira-code
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
