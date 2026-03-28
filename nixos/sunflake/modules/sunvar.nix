{ pkgs, ... }: {

  imports = [
    self.homeModules.de
  ];
  home.username = "sunvar";
  home.homeDirectory = "/home/sunvar";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    kdePackages.kate  # moved from users.users.sunvar
  ];
}
