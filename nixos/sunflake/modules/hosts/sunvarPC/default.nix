{ self, inputs, ... }: {

  flake.nixosConfigurations.sunvarPC = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = { inherit inputs self; };

    modules = [ 
      self.nixosModules.sunvarPCConfiguration
    ];  

  };
  

}
