{ inputs, self, ... }: {

  flake.nixosModules.noctalia = { pkgs, ... }: {
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    
    environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };  
 
  flake.homeModules.noctalia = { pkgs, ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs.noctalia-shell = {
      enable = true;
    }; 
    home.file.".config/noctalia/config.json" = {
      text = builtins.toJSON (builtins.fromJSON (builtins.readFile ./noctalia.json));
    };

  };
}
