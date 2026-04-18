{ pkgs, ... }: {
  programs.git = {
    enable = true;

    signing.format = null;

    includes = [
      { path = "~/.config/git/user"; }
    ];

    settings = {
      alias = {
        gr    = "log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'";
        st    = "status";
        stt   = "status -uno";
        # default git diff (git diff without global config)
        ddiff = "!GIT_CONFIG_NOSYSTEM=1 HOME=/tmp git diff";
      };

      core.editor = "nvim";
      # core.pager and interactive.diffFilter are set automatically by programs.delta.enableGitIntegration

      diff = {
        algorithm   = "histogram";
        colorMethod = "dimmed-zebra";
      };

      ghq.root = "~/Documents/vcs";

      merge.tool        = "vimdiff";
      pull.ff           = "only";
      push.default      = "simple";
      rebase.autosquash = true;
      rebase.autoStash  = true;

      fetch.prune            = true;
      push.autoSetupRemote   = true;
      merge.conflictstyle    = "zdiff3";
      rerere.enabled         = true;
      branch.sort            = "-committerdate";
      log.date               = "iso";

      init.defaultBranch = "main";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers    = true;
      max-line-length = 0;
      navigate        = true;
      side-by-side    = true;
    };
  };
}
