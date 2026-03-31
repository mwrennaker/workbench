{ self, inputs, ... }: {

  flake.nixosModules.cometConfiguration = 
{ config, pkgs, ... }:

{
  imports =
    [
      self.nixosModules.cometHardware
      self.nixosModules.syncthing
      self.nixosModules.x11
      self.nixosModules.de
      self.nixosModules.audio
      self.nixosModules.noctalia
      self.nixosModules.stylix
      inputs.home-manager.nixosModules.home-manager
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

  networking.hostName = "comet"; # Define your hostname.
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
  users.users.comet = {
    isNormalUser = true;
    description = "Comet";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true; # firefox
  programs.ssh.startAgent = true;

  # Services
  services.printing.enable = true;
  services.tailscale.enable = true;
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    obsidian
    git
    signal-desktop
    efibootmgr
    nerd-fonts.jetbrains-mono 
    vintagestory
    fastfetch
    broot
    wl-clipboard
    cliphist
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { 
    inherit inputs;
    noctaliaConfig = ../../features/noctalia-comet.json;
    outputs = {
      "eDP-1" = { scale = "1"; };
    };
    homeModules = [ 
      self.homeModules.de
      self.homeModules.noctalia
    ];
  };
  home-manager.users.comet = import ../../../home/comet.nix;

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
