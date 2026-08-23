{ ... }: {
  home.file.".agents/skills" = {
    source = ../../files/.agents/skills;
    recursive = true;
  };

  home.file.".codex/AGENTS.md".source = ../../files/.codex/AGENTS.md;
  home.file.".codex/config.toml" = {
    source = ../../files/.codex/config.toml;
    force = true;
  };

  home.file.".codex/agents" = {
    source = ../../files/.codex/agents;
    recursive = true;
  };
}
