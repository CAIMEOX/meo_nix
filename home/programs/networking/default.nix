{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wget
    curl
    google-chrome
    telegram-desktop
    v2raya
    qq
    v2ray
  ];
}
