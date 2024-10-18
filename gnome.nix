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
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit # text editor
  ]) ++ (with pkgs.gnome; [
  #  cheese # webcam tool
    gnome-music
  #  gnome-terminal
#    epiphany # web browser
    geary # email reader
    evince # document viewer
  #  gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
    pop-shell
  ];
}
