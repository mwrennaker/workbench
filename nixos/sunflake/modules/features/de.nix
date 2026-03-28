{ inputs, self, ... }: {
  flake.nixosModules.de = { pkgs, lib, config, ... }: {
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
/*
  # Enable the Cosmic Desktop Environment.
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic = {
    enable = true;
    #xwayland.enable = false; one can dream
    #excludePackages = [ "" ];
  };
*/
  };
}
