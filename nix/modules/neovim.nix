{ inputs, pkgs, ... }: {
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
  ];

  home.packages = with pkgs; [
    neovim
    nerd-fonts.hack
  ];
}
