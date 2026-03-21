
{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
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

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkb = {  # Configure keymap in X11
    layout = "us";
    variant = "";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sunvar = {
    isNormalUser = true;
    description = "Martin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  programs.firefox.enable = true; # firefox

  services.syncthing = { # syncthing
  enable = true;
  openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
  user = "sunvar";
  group = "users";
  dataDir = "/home/sunvar";  # default location for new folders
  configDir = "/home/sunvar/.config/syncthing";
  settings.gui = {
    user = "sunvar";
    };
    settings = {
      devices = {
        "sunvarpi" = { id = "N73MQEL-GWJBBFC-UPYSCAQ-6OKDK2P-PGEBVN6-U6Y5MYN-WHTSLX7-3ZACJAH"; };
        };
        folders = {
        "sunvar-pi" = {
          id = "7590-mwr";
          path = "/home/sunvar/sync/sunvar-pi/";
          devices = [ "sunvarpi" ];
          ignorePerms = true;
            };
          };

      };
  };


  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    obsidian
    git
    signal-desktop
    efibootmgr
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
             "obsidian"
           ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8384 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
