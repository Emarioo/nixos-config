let
    userName = "emarioo";
in {
  userName = userName;
  hostName = "lapis";

  # Absolute path allows home manager (home.file.".config/waybar") to have a symlink where
  # you can edit file in this repo and see change directly (after restarting waybar without needing nixos-rebuild)
  repoPath = "/home/${userName}/nixos-config";
  # Alternatively use a nix path if you want config files put in /nix/store.
  # nixos-rebuild is required to see changes.
  # repoPath = ../../.;
}
