{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    unstablepkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    unstablepkgs,
    home-manager,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = unstablepkgs.legacyPackages.${system};
    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf/configuration.nix];
    };
  in {
    packages.${system}.my-neovim = customNeovim.neovim;
    nixosConfigurations = {
      "nixos-pc" = lib.nixosSystem {
        inherit system;
        #inherit unstablepkgs;
        specialArgs = {inherit pkgs-unstable;};
        modules = [
          ./hosts/nixos-pc/configuration.nix
          ./modules/tom.nix
          {environment.systemPackages = [customNeovim.neovim];}
          ./modules/management.nix
          ./modules/hyprland.nix
          ./modules/gaming.nix
          ./modules/nvidia.nix
          ./modules/vr.nix
        ];
      };
      "nixos-t440" = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit pkgs-unstable;};
        modules = [
          ./hosts/nixos-t440/configuration.nix
          ./modules/tom.nix
          {environment.systemPackages = [customNeovim.neovim];}
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
        modules = [./home/tom/home.nix];
      };
    };
  };
}
