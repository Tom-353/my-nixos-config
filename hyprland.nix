{ config, pkgs, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  sound.enable = true;
  programs.hyprland = {
    enable = true; 
    xwayland.enable = true;
  };
  # Enable greetd login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
  # Hint Electon apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  # Install Packages
  environment.systemPackages = with pkgs; [
    hyprland
    swww # for wallpapers
    nwg-look # Theme customization
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    kitty # terminal
    wofi # app launcher
    waybar # menu bar
    dunst # notifications
    libnotify # needed for dunst
    dolphin # file manager
    mpv # media player
    networkmanagerapplet # GUI for networkmanager
    zuki-themes
    phinger-cursors
    brightnessctl
#    wob # volume/brightness popup # doesnt work
    imv # image viewer
    slurp # screenshot selector
    grim #screenshot taker
    wayidle # idle timeout
    # These packages might fix som of youre (Waybar) issues too
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
  ];
# Adding Waybar
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
    nerdfonts
    meslo-lgs-nf
  ];
}
