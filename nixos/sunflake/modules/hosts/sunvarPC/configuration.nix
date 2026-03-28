{ self, inputs, ... }: {

  flake.nixosModules.sunvarPCConfiguration = 
{ config, pkgs, ... }:

{
  imports =
    [
      self.nixosModules.sunvarPCHardware
      self.nixosModules.syncthing
      self.nixosModules.x11
      self.nixosModules.de
      self.nixosModules.audio
      self.nixosModules.steam
    ];

  # Bootloader
  boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
      };
    };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.dc=1" "amdgpu.color_range=0" "amdgpu.deep_color=0" ]; #hopefully a workaround to help my monitor for now

  networking.hostName = "sunvarPC"; # Define your hostname.
  networking.networkmanager.enable = true;

  # time zone and internationalisation.
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sunvar = {
    isNormalUser = true;
    description = "Martin";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true; # firefox

  # Services
  services.printing.enable = true;
  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    obsidian
    git
    signal-desktop
    efibootmgr
    nerd-fonts.jetbrains-mono 
    vintagestory
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.sunvar = import ../../home/sunvar.nix;

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

};

}
