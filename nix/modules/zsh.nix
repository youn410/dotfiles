{ pkgs, ... }: {
  home.packages = with pkgs; [
    fzf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtra = builtins.readFile ../../files/.zshrc;
  };
}
