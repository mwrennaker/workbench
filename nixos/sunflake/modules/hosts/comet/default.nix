{ self, inputs, ... }: {

  flake.nixosConfigurations.comet = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = { inherit inputs self; primaryUser = "comet"; };

    modules = [ 
      self.nixosModules.cometConfiguration
    ];  

  };
  

}
