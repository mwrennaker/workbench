{ pkgs, ... }: {

  imports = [
    self.homeModules.sway
  ];
  home.username = "sunvar";
  home.homeDirectory = "/home/sunvar";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    kdePackages.kate  # moved from users.users.sunvar
  ];
}
