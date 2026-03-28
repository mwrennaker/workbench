{ self, inputs, ... }: {

  flake.nixosConfigurations.sunvarPC = inputs.nixpkgs.lib.nixosSystem {

    modules = [ 
      self.nixosModules.sunvarPCConfiguration
    ];  

  };
  
  flake.homeConfigurations.sunvar = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      self.homeModules.de
      {
        home.username = "sunvar";
        home.homeDirectory = "/home/sunvar";
        home.stateVersion = "25.11";
      }
    ];
  };
}
