{ pkgs, ... }: {
  home.packages = with pkgs; [
    yazi
    filelight
    zip
    gawk
    xz
    tree
    p7zip
    unzip
    ripgrep
    jq
    eza
    gparted
    fzf
    zoxide
  ];
}