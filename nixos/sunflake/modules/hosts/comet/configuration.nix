{ self, inputs, ... }:
{

  flake.nixosModules.cometConfiguration =
    { ... }:

    {
      imports = [
        self.nixosModules.commonConfig
        self.nixosModules.commonGraphicalConfig
        self.nixosModules.cometHardware
        inputs.nixos-hardware.nixosModules.dell-latitude-7390
      ];

      networking.hostName = "comet";
      nix.settings.max-jobs = 1;
      nix.settings.cores = 2;

      systemd.services.nix-daemon.serviceConfig = {
        MemoryHigh = "5G"; # Throttles the process when it reaches 5GB
        MemoryMax = "6G"; # Forcefully kills/limits the process at 6GB
      };

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.comet = {
        isNormalUser = true;
        description = "Comet";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      programs.ssh.startAgent = true;
      services.upower.enable = true;
      services.power-profiles-daemon.enable = true;

      home-manager.extraSpecialArgs = {
        inherit inputs;
        noctaliaConfig = ../../features/noctalia-comet.json;
        outputs = {
          "eDP-1" = {
            scale = "1";
          };
        };
        homeModules = [
          self.homeModules.de
          self.homeModules.noctalia
          self.homeModules.nvim
          self.homeModules.bash
        ];
      };
      home-manager.users.comet = import ../../../home/comet.nix;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # THIS NUMBER IS NOT FOR UPDATING!!!!!
    };

}
