{ pkgs, ... }: {
  home.packages = with pkgs; [
    coreutils
    curl
    gawk
    gnugrep
    gnused
    tree
    watch
    wget
  ];
}
