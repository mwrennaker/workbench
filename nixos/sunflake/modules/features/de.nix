{ inputs, self, ... }: {
  flake.nixosModules.de = { pkgs, lib, config, ... }: {

  programs.regreet.enable = true;

   security.polkit.enable = true; # allows communication with protected files under restrictions without sudo
   programs.sway.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
   xdg.portal.enable = true;
   
  };
  
  flake.homeModules.de = { pkgs, lib, config, ... }: {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland = true;
      config  = rec { # rec makes recursive so you can referance say mod as {#modifier} instead of writing the key
        modifier = "Mod4";
        terminal = "ghostty";
	
        bars = [ ];
        
	output = {
	  "DP-2" = { position = "0 0"; scale = "2"; };
	  "HDMI-A-2" = { position = "1920 0"; };
	};
        
	workspaceOutputAssign = [
 	 { workspace = "1"; output = "DP-2"; }
 	 { workspace = "2"; output = "HDMI-A-2"; }
	];
	
	window = {
	  border = 2;
	  titlebar = false;
	  hideEdgeBorders = "smart";
	};

	gaps = {
	  inner = 8;
	  outer = 8;
	};
	
	startup = [
	  { command = "noctalia-shell"; }
	];
      };
    };

    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "JetBrainsMono Nerd Font";
	font-size = 12;
	background-opacity = .8;
      };
    };
  };
}
