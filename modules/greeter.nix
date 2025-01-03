{ config, pkgs, lib, ... }:

{
  # Enable greetd login manager
  programs.regreet = {
    enable = true;
    settings = {
      background.path = "/etc/greetd/background.png";
      GTK.application_prefer_dark_theme = true;
    };
    theme.package = pkgs.canta-theme;
    theme.name = "Canta";
  };
  environment.etc."greetd/background.png".source = ./../background.png;
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
}