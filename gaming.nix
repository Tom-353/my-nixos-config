{ config, pkgs, ... }:
{
  # Install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/tom/.steam/root/compatibilitytools.d";
  };
  environment.systemPackages = with pkgs; [
      protonup # Video game compatibility updater
      prismlauncher heroic
      dwarf-fortress mindustry #libremines
  ];

}
