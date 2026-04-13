{ pkgs, ... }: {
  home.packages = with pkgs; [
    fzf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    envExtra = builtins.readFile ../../files/.zshenv;
    initContent = builtins.readFile ../../files/.zshrc;
  };
}
