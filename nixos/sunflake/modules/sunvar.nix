{ pkgs, homeModules, ... }: {

  imports = [
    homeModules.de
  ];
  home.username = "sunvar";
  home.homeDirectory = "/home/sunvar";
  home.stateVersion = "25.11";

}
