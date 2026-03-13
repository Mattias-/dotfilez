{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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
          go_1_25_7 = unstablePkgs.go.overrideAttrs (old: {
            version = "1.25.7";
            src = pkgs.fetchurl {
              url = "https://go.dev/dl/go1.25.7.src.tar.gz";
              hash = "sha256-F48oMoICdLQ+F30y8Go+uwEp5CfdIKXkyI3ywXY88Qo=";
            };
            patches = [ ];
          });
          go_1_26 = pkgs.callPackage ./go_1_26.nix { };
        in
        pkgs.buildEnv {
          name = "home-packages";
          paths = [
            go_1_26
            #pkgs.aws-sam-cli
            #unstablePkgs.btop
            #unstablePkgs.cfssl
            #unstablePkgs.difftastic
            #unstablePkgs.ffmpeg
            #unstablePkgs.google-cloud-sdk
            #unstablePkgs.htop
            #unstablePkgs.nmap
            #unstablePkgs.pipx
            #unstablePkgs.tcpdump
            #unstablePkgs.xan
            #unstablePkgs.yq-go
            pkgs.ssm-session-manager-plugin
            unstablePkgs.awscli2
            unstablePkgs.colima
            unstablePkgs.coreutils-prefixed
            unstablePkgs.direnv
            unstablePkgs.docker-buildx
            unstablePkgs.docker-client
            unstablePkgs.fd
            unstablePkgs.fzf
            unstablePkgs.gh
            unstablePkgs.git-lfs
            unstablePkgs.gnupg
            unstablePkgs.jq
            unstablePkgs.lua-language-server
            unstablePkgs.neovim
            unstablePkgs.nixfmt
            unstablePkgs.nodejs
            unstablePkgs.python3
            unstablePkgs.ripgrep
            unstablePkgs.sad
            unstablePkgs.shellcheck
            unstablePkgs.shfmt
            unstablePkgs.socat
            unstablePkgs.starship
            unstablePkgs.tmux
            unstablePkgs.tree
            unstablePkgs.tree-sitter
            unstablePkgs.uv
          ];
        };
    };
}
