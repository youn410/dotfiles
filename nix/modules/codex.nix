{ ... }: {
  home.file.".agents/skills".source = ../../files/.agents/skills;

  home.file.".codex/AGENTS.md".source = ../../files/.codex/AGENTS.md;

  home.file.".codex/agents" = {
    source = ../../files/.codex/agents;
    recursive = true;
  };
}
