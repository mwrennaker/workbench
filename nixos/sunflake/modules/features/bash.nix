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
          nixsw-sunvar = "cd ~/workbench/nixos/sunflake/ && git add -A && git commit; git push; sudo nixos-rebuild switch --flake .#sunvarPC";
          nixup-sunvar = "cd ~/workbench/nixos/sunflake/ && nix flake update && git add -A && git commit; git push; sudo nixos-rebuild switch --flake .#sunvarPC";

          nixsw-comet = "cd ~/workbench/nixos/sunflake/ && git add -A && git commit; git push; sudo nixos-rebuild switch --flake .#comet";
          nixup-comet = "cd ~/workbench/nixos/sunflake/ && nix flake update && git add -A && git commit; git push; sudo nixos-rebuild switch --flake .#comet";

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

            # Git info for prompt
          __parse_git() {
            local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
            [ -z "$branch" ] && return

            local staged=$(git diff --cached --numstat 2>/dev/null | wc -l)
            local unstaged=$(git diff --numstat 2>/dev/null | wc -l)

            echo -n " \[\e[33m\]$branch\[\e[0m\]"
            [ $staged -gt 0 ] && echo -n " \[\e[32m\]+$staged\[\e[0m\]"
            [ $unstaged -gt 0 ] && echo -n " \[\e[31m\]!$unstaged\[\e[0m\]"
          }

          # Dynamic exit status color
          __exit_colored() {
            local exit=$?
            if [ $exit -eq 0 ]; then
              echo -n "\[\e[32m\]✓\[\e[0m\]"
            else
              echo -n "\[\e[31m\]✗ $exit\[\e[0m\]"
            fi
          }

            __set_prompt() {
              local parse_git=$(__parse_git)
              local exit_colored=$(__exit_colored)

              PS1="\[\e[36m\]┌\[\e[32m\]\u\[\e[36m\]󰬯\[\e[35m\]\H\[\e[36m\]\[\e[34m\]\w\[\e[36m\]$parse_git\[\e[0m\]\n"
              PS1+="\[\e[36m\]└─$exit_colored\[\e[36m\]:\[\e[0m\] "
            }

            PROMPT_COMMAND="__set_prompt"
            __set_prompt
        '';
      };

    };

}
