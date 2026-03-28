{ inputs, self, ... }: {
  flake.nixosModules.de = { pkgs, lib, config, ... }: {

   programs.regreet.enable = true;

   security.polkit.enable = true; # allows communication with protected files under restrictions without sudo
   programs.sway.enable = true;
   xdg.portal.wlr.enable = true;
   
  };
  
  flake.homeModule.sway = { pkgs, lib, config, ... }: {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config  = rec { # rec makes recursive so you can referance say mod as {#modifier} instead of writing the key
        modifier = "Mod4";
        terminal = "ghostty";

      };
    };
  };
}
