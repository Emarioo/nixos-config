{
  description = "NixOS and user config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.lapis = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/lapis/configuration.nix
        ./hosts/lapis/home.nix
      ];
    };
  };
}