{ config, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule
  };

}
