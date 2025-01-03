{ config, pkgs, ... }:

{
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
}