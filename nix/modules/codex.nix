{
  config,
  lib,
  pkgs,
  ...
}: let
  agentsSource = ../../files/.codex/agents;
  agentFiles = builtins.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".toml" name) (
      builtins.readDir agentsSource
    )
  );
  installAgentFiles = lib.concatMapStringsSep "\n" (file: ''
    agent_file="${config.home.homeDirectory}/.codex/agents/${file}"
    $DRY_RUN_CMD ${pkgs.coreutils}/bin/install -Dm0644 \
      ${agentsSource + "/${file}"} \
      "$agent_file.tmp"
    $DRY_RUN_CMD ${pkgs.coreutils}/bin/mv -f "$agent_file.tmp" "$agent_file"
  '') agentFiles;
in {
  home.file.".agents/skills" = {
    source = ../../files/.agents/skills;
    force = true;
  };

  home.file.".codex/AGENTS.md".source = ../../files/.codex/AGENTS.md;

  home.activation.installCodexAgents = lib.hm.dag.entryAfter ["linkGeneration"] installAgentFiles;
}
