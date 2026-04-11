let
  username = builtins.getEnv "USER";
  homeDir = builtins.getEnv "HOME";
in {
  user = {
    name = username;
    homeDirectory = homeDir;
  };
}
