{ self, inputs, ... }:
{

  flake.nixosModules.sunvarPCConfiguration =
    { pkgs, ... }:

    {
      imports = [
        self.nixosModules.commonConfig
        self.nixosModules.commonGraphicalConfig
        self.nixosModules.sunvarPCHardware
        self.nixosModules.steam
      ];
      #switch rules
      services.udev.extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0955", MODE="0666", GROUP="users"
      '';

      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.kernelParams = [
        "amdgpu.dc=1"
        "amdgpu.color_range=0"
        "amdgpu.deep_color=0"
      ]; # hopefully a workaround to help my monitor for now

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages32 = [ pkgs.pkgsi686Linux.mesa ];
      };

      networking.hostName = "sunvarPC"; # Define your hostname.

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.sunvar = {
        isNormalUser = true;
        description = "Martin";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      environment.systemPackages = with pkgs; [
        vintagestory
        inputs.chroma.packages.${pkgs.stdenv.hostPlatform.system}.term-shaders-audio
      ];

      home-manager.extraSpecialArgs = {
        inherit inputs;
        noctaliaConfig = ../../features/noctalia-sunvarPC.json;
        outputs = {
          "DP-2" = {
            position = "0 0";
            scale = "2";
          };
          "HDMI-A-2" = {
            position = "1920 0";
          };
        };
        homeModules = [
          self.homeModules.de
          self.homeModules.noctalia
          self.homeModules.nvim
          self.homeModules.bash
        ];
      };

      home-manager.users.sunvar = import ../../../home/sunvar.nix;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # THIS NUMBER IS NOT FOR UPDATING!!!!!
    };

}
