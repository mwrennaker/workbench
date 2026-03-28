{ inputs, self, ... }: {
  flake.nixosModules.de = { pkgs, lib, config, ... }: {

  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.regteet}/bin/regreet";
      user = "greeter";
    };
  };

   security.polkit.enable = true; # allows communication with protected files under restrictions without sudo
   programs.sway.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
   xdg.portal.enable = true;
   
  };
  
  flake.homeModules.de = { pkgs, lib, config, ... }: {
    wayland.windowManager.sway = {
      enable = true;
      home.packages = [ pkgs.ghostty ];
      wrapperFeatures.gtk = true;
      config  = rec { # rec makes recursive so you can referance say mod as {#modifier} instead of writing the key
        modifier = "Mod4";
        terminal = "ghostty";

      };
    };
  };
}
