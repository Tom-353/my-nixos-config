{ config, pkgs, lib, ... }:

{
  imports = [ ./greeter.nix ];
  programs.hyprland = {
    enable = true; 
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;
  # Hint Electon apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  # Desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
  };
  # Fix qt apps
#  qt = {
#    enable = true;
#    platformTheme = "gtk2";##
#    style = "gtk2";
#  };
  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;
  systemd = {
    user.services = {
      mpris-proxy = {
        description = "Mpris proxy";
        after = [ "network.target" "sound.target" ];
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      };
  # Enable authentication agent
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };
  security.polkit.enable = true;
  # Password keyring (needed for github desktop)
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
 
  services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ]; 
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    greetd-password.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  # File manager
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ];
    };
  };
  # Install Packages
  environment.systemPackages = with pkgs; [
    hypridle
    hyprshade
    hyprpicker
    polkit_gnome
    swww # for wallpapers
    #eww # Elkowars wacky widgets
    nwg-look # Theme customization
    kitty # terminal
    wofi # app launcher
    waybar # menu bar
    dunst libnotify # notifications
    mpv # media player
    networkmanagerapplet # GUI for networkmanager
    zuki-themes phinger-cursors papirus-icon-theme
    brightnessctl
    pavucontrol # volume control
    imv # image viewer
    slurp grim #screenshots
    qalculate-gtk # calculator
    gparted # partitions
    gnome-disk-utility
    wev
    # These packages might fix som of youre (Waybar) issues too
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
  ];
  # Fix waybar not displaying Hyprland workspaces, add this to your configuration:
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
  # You also probably want some fonts that contain icons, like nerdfonts.
  fonts.packages = with pkgs; [
#    nerdfonts
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  #  meslo-lgs-nf
  ];
}
