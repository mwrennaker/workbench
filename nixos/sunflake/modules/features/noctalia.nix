{ inputs, self, ... }: {

  flake.nixosModules.noctalia = { pkgs, ... }: {
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    
    environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };  
 
  flake.homeModules.noctalia = { pkgs, lib, noctaliaConfig, ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs.noctalia-shell = {
      enable = true;
    }; 
    xdg.configFile."noctalia/settings.json" = lib.mkForce {
    force = true;
    source = pkgs.writeText "noctalia-config" (builtins.toJSON (
    (builtins.fromJSON (builtins.readFile noctaliaConfig))));
    };
  };
}
