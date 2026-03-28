{ inputs, self, ... }: {
  flake.nixosModules.x11 = { pkgs, lib, config, ... }: {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.xkb = {  # Configure keymap in X11
      layout = "us";
      variant = "";
    };
  };
}
