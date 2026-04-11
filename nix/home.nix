{
  dotfilesConfig,
  ...
}: {
  imports = [
    ./modules/base.nix
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/mise.nix
    ./modules/neovim.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
  ];

  home = {
    username = dotfilesConfig.user.name;
    homeDirectory = dotfilesConfig.user.homeDirectory;
    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
