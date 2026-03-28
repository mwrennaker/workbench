{ pkgs, ... }: {

  imports = [
   features/de.nix
  ];
  home.username = "sunvar";
  home.homeDirectory = "/home/sunvar";
  home.stateVersion = "25.11";

}
