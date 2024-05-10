{ pkgs, ... }:
{
  home.packages = with pkgs; [
    optipng
    flameshot
    grim
    mpv
    # aseprite 
  ];
}