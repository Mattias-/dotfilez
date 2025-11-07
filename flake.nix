{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  };
  outputs =
    {
      self,
      nixpkgs,
      unstable,
    }:
    {
      packages."aarch64-darwin".default =
        let
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          unstablePkgs = unstable.legacyPackages."aarch64-darwin";

          # Add package overrides here
          go_1_25_1 = unstablePkgs.go.overrideAttrs (old: {
            version = "1.25.1";
            src = pkgs.fetchurl {
              url = "https://go.dev/dl/go1.25.1.src.tar.gz";
              hash = "sha256-0BDBCc7pTYDv5oHqtGvepJGskGv0ZYPDLp8NuwvRpZQ=";
            };
            patches = [ ];
          });
        in
        pkgs.buildEnv {
          name = "home-packages";
          paths = [
            pkgs.go_1_25
            unstablePkgs.awscli2
            #unstablePkgs.btop
            #unstablePkgs.cfssl
            unstablePkgs.colima
            unstablePkgs.coreutils-prefixed
            unstablePkgs.docker-buildx
            unstablePkgs.docker-client
            unstablePkgs.fd
            #unstablePkgs.ffmpeg
            unstablePkgs.fzf
            unstablePkgs.gh
            unstablePkgs.gnupg
            #unstablePkgs.google-cloud-sdk
            #unstablePkgs.htop
            unstablePkgs.jq
            unstablePkgs.neovim
            #unstablePkgs.nmap
            unstablePkgs.nodejs
            unstablePkgs.python3
            #unstablePkgs.pipx
            unstablePkgs.ripgrep
            unstablePkgs.sad
            unstablePkgs.shellcheck
            unstablePkgs.shfmt
            unstablePkgs.socat
            unstablePkgs.ssm-session-manager-plugin
            unstablePkgs.starship
            #unstablePkgs.tcpdump
            unstablePkgs.tmux
            unstablePkgs.tree
            unstablePkgs.tree-sitter
            #unstablePkgs.yq-go
            unstablePkgs.lua-language-server
            #unstablePkgs.difftastic
            pkgs.aws-sam-cli
            unstablePkgs.uv
            #unstablePkgs.xan
            unstablePkgs.nixfmt-rfc-style
          ];
        };
    };
}
