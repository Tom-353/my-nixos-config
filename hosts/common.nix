{ config, pkgs, pkgs-unstable, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT    = "cs_CZ.UTF-8";
    LC_MONETARY       = "cs_CZ.UTF-8";
    LC_NAME           = "cs_CZ.UTF-8";
    LC_NUMERIC        = "cs_CZ.UTF-8";
    LC_PAPER          = "cs_CZ.UTF-8";
    LC_TELEPHONE      = "cs_CZ.UTF-8";
    LC_TIME           = "cs_CZ.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sane to scan documents
  hardware.sane.enable = true; # enables support for SANE scanners
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  services.udev.packages = [ pkgs.sane-airscan ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install direnv for development shells
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = (with pkgs; [
    wget git htop mc tmux
    neofetch
    neovim
    gdb
    home-manager
    adwaita-icon-theme
    (python3.withPackages (python-pkgs: [
#       numpy 
#      python-pkgs.pip
    ]))
    simple-scan
    baobab gparted # edit partitions
    vlc
    playerctl
    libreoffice hunspell hunspellDicts.cs_CZ hunspellDicts.en_GB-ize hunspellDicts.en_US
    libqalculate qalculate-gtk # calculator
    nodejs # Needed for jaculus, can delete later
  ]) ++ [
    #pkgs-unstable.nixd
  ];
  
  environment.variables = {
    EDITOR = "nvim";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #nixpkgs.hostPlatform = "x86_64-linux";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
#  networking.nameservers = [ "8.8.8.8" "4.4.4.4" ];  
}