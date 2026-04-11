{ ... }: {
  programs.mise = {
    enable = true;
    enableZshIntegration = false; # .zshrc はシンボリックリンク管理のため手動でフック
    globalConfig = {
      tools = {
        node = "lts";
      };
    };
  };
}
