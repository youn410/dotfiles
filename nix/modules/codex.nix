{ ... }: {
  home.file.".agents/skills" = {
    source = ../../files/.agents/skills;
    force = true;
  };

  home.file.".codex/AGENTS.md".source = ../../files/.codex/AGENTS.md;

  home.file.".codex/agents" = {
    source = ../../files/.codex/agents;
    recursive = true;
  };
}
