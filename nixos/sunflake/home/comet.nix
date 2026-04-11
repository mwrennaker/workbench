{
  pkgs,
  config,
  homeModules,
  ...
}:
{

  imports = homeModules;

  home.username = "comet";
  home.homeDirectory = "/home/comet";
  home.stateVersion = "25.11";

  gtk.gtk4.theme = config.gtk.theme;
}
