{ config, pkgs, ... }:

let username = "caimeo";
    homeDirectory = "/home/${username}";
    configHome = "${homeDirectory}/.config";

in
{
  imports = [
    ./terminal
    ./secret
    ./programs
  ];

  home = {
    inherit username homeDirectory;
    
    sessionVariables = {
      EDITOR = "nvim";
    };
    stateVersion = "24.05";
  };

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  programs.home-manager.enable = true;
}
