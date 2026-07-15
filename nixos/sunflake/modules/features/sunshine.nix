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

        settings = {
          origin_pin = "pin"; # Set your web UI password here
            channels = [
             {
               name = "Steam";
               cmd = "steam steam://open/bigpicture";
               image-path = "steam.png";
             }
           ];
        };

        };
      };

    };

}
