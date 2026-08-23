{ ... }: {
  home.file.".agents/skills" = {
    source = ../../files/.agents/skills;
    recursive = true;
  };
}
