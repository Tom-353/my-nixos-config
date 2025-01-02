{ config, pkgs, lib, ... }:
{
  imports = [
    ./../common.nix
    ./hardware-configuration.nix
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
  boot.loader.systemd-boot.consoleMode = "auto";
  services.greetd.settings.default_session.command = "${pkgs.dbus}/bin/dbus-run-session env WLR_NO_HARDWARE_CURSORS=1 ${lib.getExe pkgs.cage} -s -- sh -c '${lib.getExe pkgs.wlr-randr} --output DP-3 --mode 2560x1440@59.951000Hz && ${lib.getExe pkgs.greetd.regreet}'";
  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "nixos-pc"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    wlx-overlay-s
    opencomposite
  ];
  services.monado = {
    enable = true;
    defaultRuntime = true;
    highPriority = true;
  };
  systemd.user.services.monado.environment = {
  STEAMVR_LH_ENABLE = "1";
  XRT_COMPOSITOR_COMPUTE = "1";
  WMR_HANDTRACKING = "0";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}