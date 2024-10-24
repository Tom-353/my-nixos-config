{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
    nixosConfigurations = {
      "nixos-pc" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-pc/configuration.nix
          ./modules/tom.nix
          ./modules/management.nix
          ./modules/hyprland.nix
          ./modules/gaming.nix
          ./modules/nvidia.nix
        ];
      };
      "nixos-t440" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-t440/configuration.nix
          ./modules/tom.nix
          ./modules/management.nix
          ./modules/hyprland.nix
          ./modules/gaming.nix
          ./modules/fingerprint.nix
        ];
      };
    };
    homeConfigurations = {
      "tom" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/tom/home.nix ];
      };
    };

  };
}
