{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      "nixos-pc" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hosts/nixos-pc/hardware-configuration.nix
          ./nvidia.nix
          ./management.nix
        ];
      };
    };

  };
}