{
  description = "Joe D's NixOS general purpose config";

  inputs = {
    # NixOS 22.05
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
  };

  output = { self, nixpkgs }: {
    nixosConfigurations.pc-cosmo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./machines/pc-cosmo.nix
      ];
    };
  };
}
