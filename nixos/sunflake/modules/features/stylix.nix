{ inputs, self, ... }: {
  flake.nixosModules.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];
    stylix = {
      enable = true;
      base16Scheme = ../themes/bright-lights.yaml;
      targets.gtk.enable = true;
      polarity = "dark";
      cursor = {
	package = pkgs.capitaine-cursors;
	name = "capitaine-cursors";
	size = 24;
      };
    };
  };

}
