{
  description = "Nix configuration for dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, ... }: {
        apps.update = {
          type = "app";
          program = toString (pkgs.writeShellScript "update-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Updating home-manager..."
            nix run nixpkgs#home-manager -- switch --flake .#myHomeConfig
            echo "Update complete!"
          '');
        };
      };

      flake = {
        homeConfigurations = let
          cfg = import ./nix/config.nix;
        in {
          myHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs { system = cfg.system; };
            extraSpecialArgs = {
              inherit inputs;
              dotfilesConfig = cfg;
            };
            modules = [ ./nix/home.nix ];
          };
        };
      };
    };
}
