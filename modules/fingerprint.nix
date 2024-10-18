{ config, pkgs, ... }:


{
  # Enable fingreprint login
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  # Install the driver
  services.fprintd = {
    enable = true;
    # If simply enabling fprintd is not enough, try enabling fprintd.tod...
    tod.enable = true;
    #tod.driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module
    tod.driver = pkgs.libfprint-2-tod1-elan; # Elan(04f3:0c4b) driver
    #tod.driver = pkgs.libfprint-2-tod1-vfs0090; # driver for 2016 ThinkPads
    #tod.driver = pkgs.libfprint-2-tod1-goodix-550a; # Goodix 550a driver (from Lenovo)
  };
}
