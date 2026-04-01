{ self, inputs, ... }: {

  flake.nixosModules.cometConfiguration = 
{ ... }:

{
  imports =
    [
      self.nixosModules.commonConfig
      self.nixosModules.cometHardware
    ];

  networking.hostName = "comet"; 
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.comet = {
    isNormalUser = true;
    description = "Comet";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.ssh.startAgent = true;
  services.upower.enable = true;

  home-manager.extraSpecialArgs = { 
    inherit inputs;
    noctaliaConfig = ../../features/noctalia-comet.json;
    outputs = {
      "eDP-1" = { scale = "1"; };
    };
    homeModules = [ 
      self.homeModules.de
      self.homeModules.noctalia
      self.homeModules.nvim
    ];
  };
  home-manager.users.comet = import ../../../home/comet.nix;

 };

}
