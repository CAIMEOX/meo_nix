{ pkgs, ... }: {
  home.packages = with pkgs; [
    elan
    coq
    luajit
    nim
    ocaml
    opam
    dune_3
    python3
    ghc
    racket
    nodejs deno
    rustup
    go
    texlive.combined.scheme-medium
    typst
    (agda.withPackages [ agdaPackages.standard-library ])
  ];
}