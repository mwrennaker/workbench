{ self, inputs, ... }: {

  flake.nixosConfigurations.sunvarPC = inputs.nixpkgs.lib.nixosSystem {

    modules = [ 
      self.nixosModules.sunvarPCConfiguration
    ];  

  };
}
