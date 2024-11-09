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
}