{ inputs, self, ... }:
{
  flake.nixosModules.sunshine =
    { ... }:
    {
      services.sunshine = {
        enable = true;
        capSysAdmin = true;
        openFirewall = true;
      };

    };

}
