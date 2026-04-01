{ self, inputs, ... }: {

  flake.nixosModules.sunvarPCConfiguration = 
{ pkgs, ... }:

{
  imports =
    [
      self.nixosModules.commonConfig
      self.nixosModules.sunvarPCHardware
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.dc=1" "amdgpu.color_range=0" "amdgpu.deep_color=0" ]; #hopefully a workaround to help my monitor for now

  networking.hostName = "sunvarPC"; # Define your hostname.
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sunvar = {
    isNormalUser = true;
    description = "Martin";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    vintagestory
  ];

  home-manager.extraSpecialArgs = { 
    inherit inputs;
    noctaliaConfig = ../../features/noctalia-sunvarPC.json;
    outputs = {
      "DP-2" = { position = "0 0"; scale = "2"; };
      "HDMI-A-2" = { position = "1920 0"; };
    };
    homeModules = [ 
      self.homeModules.de
      self.homeModules.noctalia
      self.homeModules.nvim
    ];
  };

  home-manager.users.sunvar = import ../../../home/sunvar.nix;

};

}
