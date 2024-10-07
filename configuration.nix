# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./management.nix
#      ./gnome.nix
      ./hyprland.nix
#      ./kde.nix
#      ./fingerprint.nix
      ./nvidia.nix
#      <home-manager/nixos>
#      ./home-manager.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
#    efi.efiSysMountPoint = "/boot/efi";
#    grub.enable = true;
#    grub.efiSupport = true;
#    grub.device = "nodev";
  };
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tom = {
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [
      ungoogled-chromium
      discord
      libreoffice hunspell hunspellDicts.cs_CZ hunspellDicts.en_GB-ize hunspellDicts.en_US
      krita inkscape gimp
      openscad blender prusa-slicer
      dwarf-fortress mindustry #libremines
      prismlauncher heroic
      vscode
      gcc
      baobab gparted # edit partitions
      termusic yt-dlp ffmpeg # music player + youtube downloader
      protonup # Video game compatibility updater
    ];
  };
  
  # Install firefox.
  programs.firefox.enable = true;

  # Install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    extraCompatPackages = [pkgs.proton-ge-bin];
  };
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/tom/.steam/root/compatibilitytools.d";
  };

  # Bash 
  programs.bash.shellAliases = {
    update = "nixos-rebuild switch";
    uptest = "nixos-rebuild test";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    wget git htop mc tmux
    neofetch
    home-manager
    (python3.withPackages (python-pkgs: [
#       numpy 
#      python-pkgs.pip
    ]))
    nodejs # Needed for jaculus, can delete later
    avrdude # for platformio
  ];
  
  services.udev.packages = [ 
    pkgs.platformio-core # for platformio
    pkgs.openocd # for platformio
  ];
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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
#  networking.nameservers = [ "8.8.8.8" "4.4.4.4" ];  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
