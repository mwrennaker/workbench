{ inputs, self, ... }: {
  flake.nixosModules.stylix = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
      targets.gtk.enable = true;
      polarity = "dark";
      cursor = {
	package = pkgs.bibata-cursors;
	name = "Bibata-Modern-Classic";
	size = 32;
      };
    };
  };

}
