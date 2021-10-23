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
    eslint_d
)

go_packages=(
    github.com/mattn/efm-langserver@latest
    github.com/goreleaser/goreleaser@latest
    golang.org/x/tools/gopls@latest
    github.com/golangci/golangci-lint/cmd/golangci-lint@v1.42.0
    github.com/aquasecurity/tfsec/cmd/tfsec@latest
)
