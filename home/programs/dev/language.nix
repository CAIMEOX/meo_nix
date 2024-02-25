{ config, pkgs, ... }: {
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
    texlive.combined.scheme-medium
    (agda.withPackages [ agdaPackages.standard-library ])
  ];
}