{
  pkgs,
  config,
  homeModules,
  lib,
  ...
}:
{

  imports = homeModules;

  home.username = "sunvar";
  home.homeDirectory = "/home/sunvar";
  home.stateVersion = "25.11";

  gtk.gtk4.theme = lib.mkForce config.gtk.theme;
}
