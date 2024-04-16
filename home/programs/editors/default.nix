{ pkgs, ... }:
{
  imports = [
    ./neovim
    ./helix
  ];
  home.packages = with pkgs; [
    vscode.fhs
    vim
    typora
    forester
  ];
}