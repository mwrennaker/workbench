{ self, inputs, ... }:
{
  flake.homeModules.bash =
    { ... }:
    {
      programs.bash = {
        enable = true;
        enableCompletion = true;

        historyControl = [ "ignoredups" ];
        historyFile = "~/.bash_history";

        shellAliases = {
          # navigation
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../../";

          ls = "ls -al";
          lsr = "ls -alR";

          #nixOS
          nixsw = "cd ~/workbench/nixos/sunflake/ && git add -A && git commit; git push; sudo nixos-rebuild switch --flake .#sunvarPC";
          nixup = "cd ~/workbench/nixos/sunflake/ && nix flake update && git add -A && git commit; git push; sudo nixos-rebuild switch --flake .#sunvarPC";

          nixclean = "sudo nix-collect-garbage -d";

        };

        sessionVariables = {
          # used for ssh agent for managing private keys
          SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";

          EDITOR = "nvim";
          VISUAL = "nvim";

          # XDG vars
          XDG_CONFIG_HOME = "$HOME/.config";
          XDG_CACHE_HOME = "$HOME/.cache";
          XDG_DATA_HOME = "$HOME/.local/share";
          XDG_STATE_HOME = "$HOME/.local/share";
          # Environment vars set for bash session
        };

        # here if needed
        # profileExtra = '''';
        # logoutExtra = '''';

        bashrcExtra = ''
          # .bashrc

          # Source global definitions
          if [ -f /etc/bashrc ]; then
            . /etc/bashrc
          fi

          # User specific environment
          if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
            PATH="$HOME/.local/bin:$HOME/bin:$PATH"
          fi
          export PATH

          # Custom Prompt (PS1)
          PS1='\[\e[36m\]$?\[\e[0m\] \[\e[92m\]\u󰞦\[\e[95m\]\H\[\e[0m\] \[\e[95m\]>\[\e[0m\] \[\e[94m\]\w\[\e[0m\] \[\e[95m\]<\[\e[0m\] \[\e[94m\]\A\[\e[0m\] \[\e[95m\]>\[\e[0m\] '
        '';
      };

    };

}
