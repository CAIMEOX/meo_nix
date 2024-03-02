{ pkgs, ... }: {
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
    cppcheck
    clang-tools
    nodePackages.pnpm
    ocamlPackages.findlib
    ocamlPackages.ocaml-lsp
    ocamlPackages.utop
    haskellPackages.haskell-language-server
    haskellPackages.stack
  ];
}
