{ self, inputs, ... }:
{
  flake.nixosModules.commonConfig =
    { pkgs, ... }:
    {

      imports = [
        self.nixosModules.boot
        self.nixosModules.localization
        self.nixosModules.syncthing
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
        # cli
        vim
        git
        unzip
        efibootmgr
        fastfetch
        broot
        wl-clipboard
        cliphist
        ripgrep
        eza
        kew
        p7zip

        # languages
        jdk21_headless
      ];

      # Home Manager shared settings
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

    };

}
