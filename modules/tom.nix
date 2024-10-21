{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tom = {
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    packages = with pkgs; [
      ungoogled-chromium
      discord
      krita inkscape gimp
      openscad blender prusa-slicer
      dwarf-fortress mindustry #libremines
      vscode-fhs
      gcc
      termusic yt-dlp ffmpeg # music player + youtube downloader
      github-desktop
    ];
  };
  
}