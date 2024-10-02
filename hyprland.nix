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
  # Desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # Fix qt apps
#  qt = {
#    enable = true;
#    platformTheme = "gtk2";##
#    style = "gtk2";
#  };
  # Enable bluetooth
  hardware.bluetooth.enable = true;
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
  # Install Packages
  environment.systemPackages = with pkgs; [
    hyprland
    hyprshade
    hyprpicker
    #hyprlandPlugins.hyprexpo
#    polkit # authentication agent
    pkgs.polkit_gnome
    swww # for wallpapers
    nwg-look # Theme customization
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    kitty # terminal
    wofi # app launcher
    waybar # menu bar
    dunst libnotify # notifications
    xfce.thunar # file manager
    mpv # media player
    networkmanagerapplet # GUI for networkmanager
    zuki-themes phinger-cursors papirus-icon-theme
    brightnessctl
    imv # image viewer
    slurp grim #screenshots
    wayidle # idle timeout
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
