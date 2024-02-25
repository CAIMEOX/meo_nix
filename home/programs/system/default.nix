{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    btop
    lsof
    usbutils
    which
    neofetch
    iw
    gnupg
    nix-output-monitor   
    file
  ];
}