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
    @redocly/cli@v2.24.1
    pnpm@11.0.8
    @biomejs/biome
    @getgrit/cli
)

go_packages=(
    github.com/mattn/efm-langserver@latest
    github.com/goreleaser/goreleaser/v2@latest
    golang.org/x/tools/gopls@latest
    github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.10.1
    github.com/aquasecurity/tfsec/cmd/tfsec@latest
    github.com/swaggo/swag/cmd/swag@v1.8.7
    github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
    github.com/google/ko@latest
    github.com/bufbuild/buf/cmd/buf@v1.57.2
    github.com/sigstore/cosign/v2/cmd/cosign@latest
    github.com/air-verse/air@latest
    filippo.io/mkcert@latest
    github.com/grafana/grafanactl/cmd/grafanactl@latest
    github.com/a-h/templ/cmd/templ@latest
    github.com/daveshanley/vacuum@latest
    mvdan.cc/gofumpt@latest
)
