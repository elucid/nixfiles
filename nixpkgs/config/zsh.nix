{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "rbenv" ];
    };
    shellAliases = {
      vi = "vim";
    };
    profileExtra = ''
      export NIX_PATH=/home/vagrant/.nix-defexpr/channels/
    '';
    initExtra = ''
      stty stop undef
      stty start undef
      setopt noflowcontrol

      export TERM=xterm-256color
      [ -n "$TMUX" ] && export TERM=screen-256color
      source ${pkgs.fzf}/share/fzf/completion.zsh
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh

      case $TERM in
      screen*)
      precmd(){
      # Restore tmux-title to 'zsh'
      printf "\033kzsh\033\\"
      # Restore urxvt-title to 'zsh'
      print -Pn "\e]2;zsh:%~\a"
      }
      preexec(){
      # set tmux-title to running program
      printf "\033k$(echo "$1" | cut -d" " -f1)\033\\"
      # set urxvt-title to running program
      print -Pn "\e]2;zsh:$(echo "$1" | cut -d" " -f1)\a"
                }
      ;;
      esac

      PATH=$PATH:$HOME/.nix-profile/bin
      PATH=$PATH:$HOME/.npm-prefix/bin
      PATH=$PATH:$HOME/bin

      export LOCALE_ARCHIVE_2_11="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
      export LOCALE_ARCHIVE_2_27="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
      export LOCALE_ARCHIVE="/usr/bin/locale"

      export FZF_DEFAULT_COMMAND='fd --type f --exclude .git'
    '';
  };
}
