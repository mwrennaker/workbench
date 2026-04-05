cd workbench/nixos/sunflake/
vim modules/features/bash.nix 
fc-list | awk -F: '{print $2}' | sort -u
vim modules/features/common.nix 
vim modules/features/fonts.nix
vim modules/features/common.nix 
nixsw
vim modules/features/fonts.nix
nixsw
vim modules/features/fonts.nix
nixsw
vim modules/features/fonts.nix
nixsw
vim modules/features/fonts.nix
nixsw
vim modules/features/fonts.nix
nixsw
fc-list
fc-list : family | sort -u
fc-list | awk -F: '{print $2}' | sort -u
echo $PS1
echo -e "\ue0b0 \ue0b1 \ue0b2 \ue0b3"
[200~~
[200

vim modules/features/bash.nix 
nixsw
git status --porcelain 
git symbolic-ref HEAD
vim modules/features/bash.nix 
git symbolic-ref --short HEAD 
git symbolic-ref --short HEAD 2>/dev/null
git status --porcelain 2>/dev/null
git diff --cached --numstat 2>/dev/null
git diff --numstat 2>/dev/null
git diff --numstat 2>/dev/null | wc -l
git diff --cached --numstat 2>/dev/null | wc -l
return 
cd workbench/
cd nixos/sunflake/
cd
cd workbench/nixos/sunflake/
cd banaa
vim modules/features/bash.nix 
git branch 2>/dev/null
git diff --cached --numstat | wc -l
git diff --numstat | wc -l
__git_info() {     local branch=$(git branch 2>/dev/null | grep '*' | sed 's/* //');     [ -z "$branch" ] && return;     echo -n " \[\e[33m\] $branch\[\e[0m\]"; }
__git_info() {     local branch=$(git branch 2>/dev/null | grep '*' | sed 's/* //');     [ -z "$branch" ] && return;     echo -n " \[\e[33m\] $branch\[\e[0m\]"; }
__git_info
__exit_colored() {     local exit=$?;     if [ $exit -eq 0 ]; then         echo -n "\[\e[32m\]✓\[\e[0m\]";     else         echo -n "\[\e[31m\]✗ $exit\[\e[0m\]";     fi; }
# Run a failing command first
ls /nonexistent
__exit_colored
echo $PATH | grep git
echo $PATH 
echo $PATH | grep git
type __git_branch
type __git_info
vim modules/hosts/sunvarPC/configuration.nix 
vim home/sunvar.nix 
vim modules/features/bash.nix 
nixsw
ls
cd workbench/
ls
vim nixos/sunflake/modules/features/bash.nix 
nixsw
vim modules/features/bash.nix 
nixsw
cd workbench/
cd nixos/
vim sunflake/modules/features/bash.nix 
nixsw
for i in {0..15}; do      printf "\e[48;5;${i}m %3d \e[0m" $i;     [ $((i % 8)) -eq 7 ] && echo; done
cd workbench/
cd nixos/sunflake/
git status 
...
ls
cd nixos/sunflake/
vim modules/features/bash.nix 
nixsw
cd workbench/
ls
cd nixos/sunflake/
vim modules/features/bash.nix 
echo "[\e[48;5;33m\]"
printf "\e[48;5;32m This is color 32 (blue) \e[0m\n"
printf "\e[48;5;124m This is color 32 (blue) \e[0m\n"
printf "\e[48;5;33m This is color 32 (blue) \e[0m\n"
printf "\e[48;5;240m This is color 32 (blue) \e[0m\n"
printf "\e[48;5;32m This is color 32 (blue) \e[0m\n"
printf "\e[38;5;32m\e[48;5;32mThis is color 32 (blue)\e[0m\n\e[30;5;32m"
printf "\e[38;5;32m\e[48;5;32mThis is color 32 (blue)\e[0m\e[30;5;32m"
printf "\e[38;5;32m\e[48;5;32mThis is color 32 (blue)\e[0m\e[38;5;32m"
printf "\e[38;5;32m\e[38;5;31m\e[48;5;32mThis is color 32 (blue)\e[0m\e[38;5;32m"
printf "\[\e[48;5;32m\] \u \[\e[0m\]\[\e[48;5;33m\]\[\e[48;5;33m\]"
printf "\[\e[48;5;32m\] stuff \[\e[0m\]\[\e[48;5;33m\]\[\e[48;5;33m\]"
printf "\e[48;5;32m user \e[0m\n"
printf "\e[48;5;32m user \e[0m\e[48;5;240m ~/projects \e[0m\e[48;5;33m main \e[0m\n"
printf "\e[48;5;32m\e[38;5;0m user \e[0m\e[48;5;240m\e[38;5;15m ~/projects \e[0m\n"
printf "\e[48;5;32m user \e[0m\e[48;5;240m ~/projects \e[0m\n"
printf "\e[48;5;32m \u \e[0m\e[48;5;240m \w \e[0m\e[48;5;33m main \e[0m\n"
printf "\e[48;5;32m \u \e[0m \w \$ "
printf "\e[48;5;32m \u@\h \e[0m\e[48;5;240m \w \e[0m\e[48;5;33m main \e[0m\n\$ "
printf "\e[48;5;32m \u@\h \e[0m\e[48;5;240m \w \e[0m\n\e[48;5;236m \A \e[0m\$ "
printf "\e[31mThis uses your terminal's red color\e[0m\n"
printf "\e[41mRed background (uses your terminal's red)\e[0m\n"
echo "=== Your Terminal's Color Scheme ==="
echo ""
echo "Standard colors:"
for i in {30..37}; do     printf "\e[${i}m %3d: Text color %d\e[0m\n" $i $i; done
echo ""
echo "Bright colors:"
for i in {90..97}; do     printf "\e[${i}m %3d: Text color %d\e[0m\n" $i $i; done
echo ""
echo "Background colors:"
for i in {40..47} {100..107}; do     printf "\e[${i}m %3d: Background %d \e[0m\n" $i $i; done
ls
nixsw
git pull
nixsw 
ls fakefile
cd workbench/nixos/sunflake/
ls
...
ls
git add -A
git status
git commit 
..
ls fake
printf "\e[48;5;196m \u \e[0m\e[48;5;46m \w \e[0m\e[48;5;226m main \e[0m\n\$ "
cd workbench/nixos/sunflake/
vim modules/features/bash.nix 
exa
nix run github:eza-community/eza
vim modules/features/common.nix 
nixsw-sunvar 
eza
eza -1
eza -l
eza -lT
eza -lR
eza -lRT
eza -l --icons=auto
eza -lT --icons=auto
eza -lT --icons=auto --color-scale-mode=gradient
eza -lT --icons=auto
eza -l --icons=auto
vim modules/features/bash.nix 
nix run bat
nix shell -p bat
nix-shell -p bat
bat
ls
bat flake.nix 
bat flake.lock 
cliphist --help
cliphist list
wl-copy --help 
wl-paste --help 
wl-paste
$(wl-paste)
paste
paste --help
cd
;s
ls
cd countertop/
ls
ls nixos/
vim ~/workbench/nixos/sunflake/modules/features/bash.nix 
nixsw-sunvar 
cd workbench/nixos/sunflake/
bat flake.nix 
