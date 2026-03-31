{ self, inputs, ... }: {
  flake.nixosModules.commonConfig = { pkgs, ... }: {
    
    boot.loader = { # enabling grub and bootloader config
      efi.canTouchEfiVariables = true;
      grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
      };
    };

    # Timezone and internationalisation
    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS        = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT    = "en_US.UTF-8";
      LC_MONETARY       = "en_US.UTF-8";
      LC_NAME           = "en_US.UTF-8";
      LC_NUMERIC        = "en_US.UTF-8";
      LC_PAPER          = "en_US.UTF-8";
      LC_TELEPHONE      = "en_US.UTF-8";
      LC_TIME           = "en_US.UTF-8";
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Common services
    services.printing.enable = true;
    services.tailscale.enable = true;
    services.openssh.enable = true;

    # Common packages
    environment.systemPackages = with pkgs; [
      vim
      obsidian
      git
      signal-desktop
      efibootmgr
      nerd-fonts.jetbrains-mono
      fastfetch
      broot
      wl-clipboard
      cliphist
    ];

    # Common programs
    programs.firefox.enable = true;

    # Home Manager shared settings
    home-manager.useGlobalPkgs    = true;
    home-manager.useUserPackages  = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };

}
