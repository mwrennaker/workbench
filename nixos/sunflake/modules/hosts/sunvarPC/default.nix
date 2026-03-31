{ self, inputs, ... }: {

  flake.nixosConfigurations.sunvarPC = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = { inherit inputs self; primaryUser = "sunvar"; };

    modules = [ 
      self.nixosModules.sunvarPCConfiguration
    ];  

  };
  

}
