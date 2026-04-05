{
  self,
  inputs,
  ...
}:
{

  flake.nixosConfigurations.comet = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = {
      inherit inputs self;
      primaryUser = "comet";
      nixos-hardware = inputs.nixos-hardware;
    };

    modules = [
      self.nixosModules.cometConfiguration
    ];

  };

}
