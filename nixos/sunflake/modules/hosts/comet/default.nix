{
  self,
  inputs,
  nixos-hardware,
  ...
}:
{

  flake.nixosConfigurations.comet = inputs.nixpkgs.lib.nixosSystem {

    specialArgs = {
      inherit inputs self;
      primaryUser = "comet";
    };

    modules = [
      self.nixosModules.cometConfiguration
      nixos-hardware.nixosModules.dell-latitude-7390
    ];

  };

}
