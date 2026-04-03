{ inputs, self, ... }:
{
  flake.nixosModules.steam =
    { ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      environment.sessionVariables = {
        STEAM_FORCE_DESKTOPUI_SCALING = "1";
      };
    };
}
