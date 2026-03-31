{ inputs, self, ... }: {
  flake.homeModules.nvim = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      
    };
  };
}
