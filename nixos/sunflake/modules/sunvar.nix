{ pkgs, self, ... }: {

  imports = [
    self.homeModules.de
  ];
  home.username = "sunvar";
  home.homeDirectory = "/home/sunvar";
  home.stateVersion = "25.11";

}
