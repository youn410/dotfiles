{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "nomu";
in {
  nixpkgs = {
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
  };

  home = {
    inherit username;
    homeDirectory = "/Users/${username}";

    packages = with pkgs; [
      coreutils
      curl
      delta
      fzf
      git
      neovim
      gnused
      gnugrep
      gawk
      tmux
      tree
      watch
    ];

    stateVersion = "24.05";
  };

  programs = {
    # https://github.com/nix-community/nix-direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
