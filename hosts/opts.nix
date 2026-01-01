{}:
let
    getEnv = env_var: default_value: if builtins.getEnv env_var != "" then env_var else default_value;
    userName = getEnv "NIX2_USER" "emarioo";
in {
  userName = userName;
  hostName = getEnv "NIX2_HOSTNAME" "lapis";
  repoPath = getEnv "NIX2_CONFIG" ../.;
}
