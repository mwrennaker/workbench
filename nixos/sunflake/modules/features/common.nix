{ self, inputs, ... }:
{
  flake.nixosModules.commonConfig =
    { pkgs, ... }:
    {

      imports = [
        self.nixosModules.boot
        self.nixosModules.localization
        self.nixosModules.syncthing
        self.nixosModules.x11
        self.nixosModules.de
        self.nixosModules.audio
        self.nixosModules.noctalia
        self.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
      ];

      # nix settings
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;

      # Common services
      services.printing.enable = true;
      services.tailscale.enable = true;
      services.openssh.enable = true;

      # Common packages
      environment.systemPackages = with pkgs; [
        # gui
        obsidian
        signal-desktop

        # cli
        vim
        git
        efibootmgr
        fastfetch
        broot
        wl-clipboard
        cliphist
        ripgrep

        # fonts
        nerd-fonts.jetbrains-mono
      ];

      # Common programs
      programs.firefox.enable = true;

      # Home Manager shared settings
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # THIS NUMBER IS NOT FOR UPDATING!!!!!
    };

}
