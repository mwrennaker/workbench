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
        self.nixosModules.fonts
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

      ];

      # Common programs
      programs.firefox.enable = true;

      # Home Manager shared settings
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

    };

}
