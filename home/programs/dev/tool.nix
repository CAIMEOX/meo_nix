{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    tokei
    docker
    gdb
    bun
    tmux
    bat
    glow
    nixpkgs-fmt
    gnumake
    nil
    nodePackages.pnpm
    ocamlPackages.findlib
    ocamlPackages.ocaml-lsp
    ocamlPackages.utop
    haskellPackages.haskell-language-server
    haskellPackages.stack
  ];
}
