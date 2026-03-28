{ inputs, self, ... }: {

  flake.nixosModules.syncthing = { pkgs, lib, config, ... }: {
    
    services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
    user = "sunvar";
    group = "users";
    dataDir = "/home/sunvar";  # default location for new folders
    configDir = "/home/sunvar/.config/syncthing";
    settings.gui = {
      user = "sunvar";
      };
      settings = {
        devices = {
          "sunvarpi" = { id = "N73MQEL-GWJBBFC-UPYSCAQ-6OKDK2P-PGEBVN6-U6Y5MYN-WHTSLX7-3ZACJAH"; };
          };
          folders = {
          "sunvar-pi" = {
            id = "7590-mwr";
            path = "/home/sunvar/sync/sunvar-pi/";
            devices = [ "sunvarpi" ];
            ignorePerms = true;
              };
           };

      };
  };
  networking.firewall.allowedTCPPorts = [ 8384 ]; #opening port for gui

  };

}
