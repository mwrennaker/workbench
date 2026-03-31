{ self, inputs, ... }: {
  flake.nixosModules.boot = { ... }: {
    boot.loader = { # enabling grub and bootloader config
      efi.canTouchEfiVariables = true;
      grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
      };
    };
  };

}
