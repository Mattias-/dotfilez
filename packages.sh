#!/bin/bash

# shellcheck disable=SC2034

pip_packages=(
    black
    yamllint
    pre-commit
    prowler-cloud
)

npm_packages=(
    dockerfile-language-server-nodejs
    vscode-langservers-extracted
    pyright
    typescript-language-server
    typescript
    aws-cdk
    prettier
    rdme
    @redocly/cli
    @stoplight/spectral-cli
    pnpm
)

go_packages=(
    github.com/mattn/efm-langserver@latest
    github.com/goreleaser/goreleaser@latest
    golang.org/x/tools/gopls@latest
    github.com/golangci/golangci-lint/cmd/golangci-lint@v1.55.1
    github.com/aquasecurity/tfsec/cmd/tfsec@latest
    github.com/swaggo/swag/cmd/swag@v1.16.2
    github.com/deepmap/oapi-codegen/v2/cmd/oapi-codegen@latest
    github.com/mrtazz/checkmake/cmd/checkmake@latest
    github.com/google/ko@latest
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
