{ config, pkgs, pkgs-unstable, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tom = {
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    packages = [
      pkgs.ungoogled-chromium
      pkgs.discord
      pkgs.krita pkgs.inkscape pkgs.gimp
      pkgs.openscad pkgs.blender pkgs-unstable.prusa-slicer
      pkgs.dwarf-fortress pkgs.mindustry #libremines
      pkgs.vscode-fhs
      pkgs.termusic pkgs-unstable.yt-dlp pkgs.ffmpeg # music player + youtube downloader
      pkgs.github-desktop
    ];
  };
  
}