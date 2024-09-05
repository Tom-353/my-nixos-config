{ config, pkgs, ... }:

{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # Configure keymap in X11
    xkb = {
      layout = "us,cz";
      options = "grp:win_space_toggle";
      variant = "";
    };
  };
}
