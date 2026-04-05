{ self, inputs, ... }:
{
  flake.nixosModules.commonGraphicalConfig =
    { pkgs, ... }:
    {

      imports = [
        self.nixosModules.x11
        self.nixosModules.de
        self.nixosModules.audio
        self.nixosModules.noctalia
        self.nixosModules.stylix
        self.nixosModules.fonts
        inputs.home-manager.nixosModules.home-manager
      ];

      # Common packages
      environment.systemPackages = with pkgs; [
        # gui
        obsidian
        signal-desktop

      ];

      # Common programs
      programs.firefox.enable = true;

    };

}
