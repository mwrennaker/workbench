{ self, inputs, ... }:
{

  flake.nixosConfigurations.andromeda = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = {
      inherit inputs self;
      primaryUser = "andromeda";
    };

    modules = [
      self.nixosModules.andromedaConfiguration
    ];

  };

}
