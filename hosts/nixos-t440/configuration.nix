{ config, pkgs, ... }:
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
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.

  environment.systemPackages = with pkgs; [ zbar ];

}