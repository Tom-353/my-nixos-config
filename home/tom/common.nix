{ config, pkgs, lib, ... }:
let
  primary_colour = "33ccff";
  secondary_colour = "00ff99";
  background_colour = "64727d";
  border_radius = "10";
  border_width = "2";
  font = "DroidSansM Nerd Font";
  icon_theme = "Papirus-Dark";
  flake_source = "github:Tom-353/my-nixos-config";
in
{  
  gtk = {
    enable = true;
    font.name = "${font}";
    theme = {
      name = "Juno";
      package = pkgs.juno-theme;
    };
    iconTheme = {
      name = "${icon_theme}";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      #Settings = ''
      #  gtk-application-prefer-dark-theme=1
      #'';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  qt = {
    #enable = true;
    #platformTheme = "qtct";
    # style = {
    #   package = pkgs.libsForQt5.breeze-qt5;
    #   name = "breeze";
    # };
  };
  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 200;
        height = 300;
        offset = "15x15";
        origin = "top-right";
        frame_color = "#${primary_colour}";
        font = "${font}";
        frame_width = "${border_width}";
        corner_radius = "${border_radius}";
        background = "#${background_colour}aa";
        highlight = "#ffffff"; # progress bar colour
        progress_bar_max_width = 200;
        progress_bar_frame_width = "${border_width}";
        progress_bar_corner_radius = 6;
        progress_bar_height = 14;
      };
      urgency_low = {
        foreground = "#29ce29";
        timeout = 5;
      };
      urgency_normal = {
        foreground = "#ffffff";
        timeout = 10;
      };
      urgency_critical = {
        foreground = "#ff0000";
      };
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.7";
    };
  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
     (pkgs.writeShellScriptBin "hm-update" ''
       home-manager switch --flake ${flake_source} && hyprctl reload
     '')
     (pkgs.writeShellScriptBin "os-update" ''
       sudo nixos-rebuild switch --flake ${flake_source}
     '')
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr" = {
      source = ./hyprland;
  #    onChange = ''
  #      hyprctl reload
  #    '';
    };
    ".config/waybar".source = ./waybar;
    ".config/wofi/style.css".source = ./wofi/style.css;
    ".config/wofi/config".text = lib.generators.toKeyValue {}{
      matching = "multi-contains";
      dynamic_lines = true;
    };
    ".profile".text = ''
      PS1="\n\[\033[0;34m\]\[\033[30;44m\]\u\[\033[34;46m\]\[\033[30m\]\h\[\033[0;36m\]\[\033[32m\] \w \n\[\033[32m\]$ \[\033[0m\]"
    '';
    ".bashrc".text = ''
      PS1="\n\[\033[0;34m\]\[\033[30;44m\]\u\[\033[34;46m\]\[\033[30m\]\h\[\033[0;36m\]\[\033[32m\] \w \n\[\033[32m\]$ \[\033[0m\]"
    '';
    ".config/imv/config".text = lib.generators.toINI {}{
      options.overlay_font = "Monospace:12";
      binds = {
        "<Ctrl+r>" = "rotate by 90";
        "<Ctrl+f>" = "flip horizontal";
        "n" = "next 1";
        "<Shift+N>" = "prev 1";
        "<Escape>" = "quit";
      };
    };
  };
}
