{
  description = "NixOS config flake for Sunvar";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... } @ inputs: 
  {
    nixosConfigurations.sunvarPC = nixpkgs.lib.nixosSystem {
      modules = [
        ./sunvarnix.nix
      ];
    };  
  };
}
