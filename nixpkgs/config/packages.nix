{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ack
    ngrok
    neovim
    nodejs-12_x
    ripgrep
    solargraph
    tig
    fd
    tmate
    rustup
    fzf
    direnv
    gitAndTools.hub
  ];
}
