{ inputs, self, ... }: {

  flake.nixosModules.noctalia = { pkgs, ... }: {
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    
    environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };  
 
  flake.homeModules.noctalia = { pkgs, ... }: {
    programs.noctalia-shell = {
      enable = true;

    }; 

  };
}
