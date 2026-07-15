{ inputs, self, ... }:
{
  flake.nixosModules.sunshine =
    { ... }:
    {
      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;

        applications = {
          apps = [
            {
              name = "Steam";
              cmd = "steam steam://open/bigpicture";
              image-path = "steam.png";
            }
          ];
        };

      };
    };

}
