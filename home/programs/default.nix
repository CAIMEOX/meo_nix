{ config, pkgs, ... }:
{
  imports = [
    ./dev
    ./system
    ./file
    ./media
    ./editors
    ./networking
  ];
}