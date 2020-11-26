{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vagrant";
  home.homeDirectory = "/home/vagrant";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  imports = [
    ./config/git.nix
    ./config/zsh.nix
    ./config/packages.nix
    ./SpaceVim.d/space-vim.nix
  ];

  home.file.".tmux.conf".source = ./config/tmux.conf;
  home.file.".tmate.conf".source = ./config/tmate.conf;
  home.file.".ackrc".source = ./config/ackrc;
  home.file."/bin/colorterm.sh".source = ./bin/colorterm.sh;

  programs.autojump.enable = true;

  programs.zsh = {
    oh-my-zsh = { theme = "minimal"; };
  };
}
