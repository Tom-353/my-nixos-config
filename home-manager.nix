{ config, pkgs, ... }:

{
  home-manager.users.tom = { pkgs, ... }: {
    home.packages = [  ];
    programs.bash.enable = true;

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.05";
  };
  home-manager.useGlobalPkgs = true;
}
