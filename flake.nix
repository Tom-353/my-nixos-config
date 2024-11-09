{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    unstablepkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, unstablepkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = unstablepkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      "nixos-pc" = lib.nixosSystem {
        inherit system;
        #inherit unstablepkgs;
        specialArgs = { inherit pkgs-unstable; };
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
        inherit system;
        specialArgs = { inherit pkgs-unstable; };
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
