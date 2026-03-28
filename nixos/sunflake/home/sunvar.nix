{ pkgs, homeModules, ... }: {

  imports = homeModules;
 
  home.username = "sunvar";
  home.homeDirectory = "/home/sunvar";
  home.stateVersion = "25.11";
}
