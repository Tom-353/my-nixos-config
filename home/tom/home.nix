{ config, pkgs, ... }:
let
  primary_colour = "33ccff";
  secondary_colour = "00ff99";
  background_colour = "46466b";
  border_radius = "10";
  border_width = "2";
  font = "Droid Sans Mono";
  icon_theme = "Papirus-Dark";
  flake_source = "github:Tom-353/my-nixos-config";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tom";
  home.homeDirectory = "/home/tom";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  nixpkgs.config.allowUnfree = true;
  
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
  wayland.windowManager.hyprland = {
   enable = false;
   #systemd.enable = false;
   settings = {
    monitor = ",preferred,auto,auto";
    # Set programs that you use
    "$terminal" = "kitty";
    "$fileManager" = "$terminal mc";
    "$menu" = "wofi --show drun";
    "$editor" = "$terminal nano";
    "$browser" = "firefox";
    "$audio_notif" = ''
      notify-send -u low -h INT:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf"%d\n", $2*100}') "Volume"
    '';
    "$brightness_notif" = ''
      notify-send -u low -h INT:value:$(brightnessctl get | awk '{printf"%d\n", $1/8.51}') "Brightness"
    '';
    "exec-once" = [
      "waybar" "swww-daemon" "nm-applet --indicator" "dunst"
      "polkit-agent-helper-1" "systemctl start --user polkit-gnome-authentication-agent-1"
      "hyprctl setcursor phinger-cursors-dark 24"
      "firefox"
    ];
    "env" = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "QT_QPA_PLATFORMTHEME, qt6ct"
    ];
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = "${border_width}";
      "col.active_border" = "rgba(${primary_colour}ee) rgba(${secondary_colour}ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };
    decoration  = {
      rounding = "${border_radius}";
      #active_opacity = "1.0";
      #inactive_opacity = "0.8";
      drop_shadow = false;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
      blur = {
        enabled = false;
        size = 5;
        passes = 1;
        new_optimizations = true;
        ignore_opacity = true;
        vibrancy = "0.1696";
        #vibrancy_darkness = 0.5;
      };
    };
    animations = {
      enabled = true;
    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for m>
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    dwindle = {
      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod >
      preserve_split = true; # You probably want this
    };
    master = {
      new_status = "master";
    };
    misc = {
      vfr = true;
      force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo = true; # If true disables the random hyprland logo / anime >
    };
    input = {
      kb_layout = "us, cz";
      kb_variant = "";
      kb_model = "";
      kb_options = "grp:win_space_toggle";
      kb_rules = "";
      follow_mouse = 1;
      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      touchpad = {
        natural_scroll = true;
      };
    };
    gestures = {
      workspace_swipe = true;
    };
    "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
    bind = [
      "$mainMod SHIFT, E, exec, dolphin"
      "$mainMod SHIFT, F, fullscreen, 0"
      "$mainMod, B, exec, $browser"
      "$mainMod, C, killactive,"
      "$mainMod, D, exec, discord"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, Escape, exit,"
      "$mainMod, F, fullscreen, 1"
      "$mainMod, J, togglesplit," # dwindle"
      #"$mainMod, K, exec, $terminal"
      "$mainMod, L, exec, libreoffice"
      "$mainMod, M, exec, [workspace special:magic silent] $terminal termusic"
      "$mainMod, P, pseudo," # dwindle"
      "$mainMod, Q, exec, $terminal"
      "$mainMod, R, exec, $menu"
      "$mainMod, T, togglefloating,"
      "$mainMod, V, exec, code"
      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"
      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      # Example special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"
      # Scroll through existing workspaces with mainMod + scroll or mainMod + pgup/dn
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
      "$mainMod, Next, workspace, e+1"
      "$mainMod, Prior, workspace, e-1"
      # Fn keys
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle & notify-send 'Muted'"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle & notify-send 'Mute mic'"
      # Open QR code
      ", XF86Display, exec, zbarcam -1 --raw | wl-copy"
      #", XF86WLAN, exec, nm-applet # do not use, SF86WLAN automatically toggles wifi"
      ", XF86Tools, exec, code -n ./.config/home-manager/"#$editor .config/hypr/hyprland.conf"
      "SHIFT, XF86Tools, exec, code -n /etc/nixos/"
      ", XF86Search, exec, $menu"
      #" XF86Launch, exec, "
      ", XF86Explorer, exec, $terminal htop"
      # Screenshots
      ", Print, exec, grim -g '$(slurp)'"
      "SHIFT, Print, exec, grim -g '$(slurp)' - | wl-copy"
    ];
    binde = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+ && $audio_notif"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%- && $audio_notif"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%- && $brightness_notif"
      ", XF86MonBrightnessUp, exec, brightnessctl set 10%+ && $brightness_notif"
    ];
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
    windowrulev2 = [
      "opacity 0.75, class:^($terminal)$"
      "suppressevent maximize, class:.*" # You'll probably like this.
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "move 0 50, title:^(Picture-in-Picture)$"
      "size 480 240, title:^(Picture-in-Picture)$"
      "opaque, title:^(Picture-in-Picture)$"
      "workspace special:magic silent, class:^(discord)$"
    ];
   };
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
        font = "${font} 10";
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
    ".config/wofi".source = ./wofi;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
