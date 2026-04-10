{ inputs, self, ... }:
{
  flake.nixosModules.de =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {

      programs.regreet.enable = true;
      programs.regreet.settings = {
        background = {
          path = "/usr/share/backgrounds/greeter.jpg";
          fit = "Fill";
        };
      };

      security.polkit.enable = true; # allows communication with protected files under restrictions without sudo
      programs.sway.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
      xdg.portal.enable = true;

    };

  flake.homeModules.de =
    {
      pkgs,
      lib,
      config,
      outputs,
      ...
    }:
    {
      wayland.windowManager.sway = {
        enable = true;
        checkConfig = false;
        wrapperFeatures.gtk = true;
        xwayland = true;
        extraConfig = ''
                  unbindsym Mod4+Space
          	unbindsym Mod4+s
          	unbindsym Mod4+w
          	unbindsym Mod4+a
        '';
        config = rec {
          # rec makes recursive so you can referance say mod as {#modifier} instead of writing the key
          modifier = "Mod4";
          terminal = "ghostty";

          bars = [ ];

          output = outputs;

          workspaceOutputAssign = [
            {
              workspace = "1";
              output = "DP-2";
            }
            {
              workspace = "2";
              output = "HDMI-A-2";
            }
          ];

          window = {
            border = 2;
            titlebar = false;
            hideEdgeBorders = "smart";
          };

          gaps = {
            inner = 8;
            outer = 8;
          };

          startup = [
            { command = "noctalia-shell"; }
          ];

          keybindings =
            let
              mod = modifier;
            in
            lib.mkOptionDefault {
              "${mod}+Return" = "exec ghostty";
              "${mod}+Shift+q" = "kill";

              "${mod}+d" = "exec noctalia-shell ipc call launcher toggle";

              "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
              "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
              "XF86AudioMute" = "exec noctalia-shell ipc call media playPause";
            };
        };
      };

      programs.ghostty = {
        enable = true;
        settings = {
          font-family = "JetBrainsMono Nerd Font";
          font-size = 12;
          background-opacity = 0.75;
          theme = "Oxocarbon";
        };
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = false;
        desktop = "$HOME/countertop/desk";
        documents = "$HOME/countertop";
        download = "$HOME/quarantine";
        music = "$HOME/countertop/tunes";
        pictures = "$HOME/countertop/pics";
        publicShare = "$HOME/sync";
        templates = "$HOME/dustycloset/templates";
        videos = "$HOME/countertop/clips";
      };
    };
}
