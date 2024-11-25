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
      curl
      fzf
      git
      neovim
      volta
    ];

    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
