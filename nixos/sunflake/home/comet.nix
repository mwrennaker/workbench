{ pkgs, homeModules, ... }: {

  imports = homeModules;
 
  home.username = "comet";
  home.homeDirectory = "/home/comet";
  home.stateVersion = "25.11";
}
