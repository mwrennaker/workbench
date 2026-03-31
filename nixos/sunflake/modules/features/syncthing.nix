{ inputs, self, ... }: {

  flake.nixosModules.syncthing = { pkgs, lib, config, primaryUser, ... }: {
    
    services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
    user = primaryUser;
    group = "users";
    dataDir = "/home/${primaryUser}";  # default location for new folders
    configDir = "/home/${primaryUser}/.config/syncthing";
    settings.gui = {
      user = primaryUser;
      };
      settings = {
        devices = {
          "sunvarpi" = { id = "N73MQEL-GWJBBFC-UPYSCAQ-6OKDK2P-PGEBVN6-U6Y5MYN-WHTSLX7-3ZACJAH"; };
          };
          folders = {
          "sunvar-pi" = {
            id = "7590-mwr";
            path = "/home/${primaryUser}/sync/sunvar-pi/";
            devices = [ "sunvarpi" ];
            ignorePerms = true;
              };
           };

      };
  };
  networking.firewall.allowedTCPPorts = [ 8384 ]; #opening port for gui

  };

}
