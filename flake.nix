{
  description = "Meo NixOS configuration";

  outputs = { home-manager, nixpkgs, forester, foundry, ... }@inputs:

    let
      userSettings = rec {
        username = "caimeo";
        name = "CAIMEOX";
        email = "";
        theme = "nord";
        wmType = "wayland";
        wm = "hyprland";
        term = "kitty";
        editor = "nvim";
        font = "JetBrains Mono";
        fontPkg = pkgs.noto-fonts;
        spawnEditor = if (editor == "emacsclient") then
          "emacsclient -c -a 'emacs'"
        else
          (if ((editor == "vim") || (editor == "nvim")
            || (editor == "nano")) then
            "exec " + term + " -e " + editor
          else
            editor);
        browser = "google-chrome-stable";
      };

      systemSettings = {
        system = "x86_64-linux";
        hostname = "meo";
        profile = "meo";
        timezone = "Asia/Shanghai";
        locale = "en_US.UTF-8";
      };

      pkgs = import nixpkgs {
        inherit forester;
        inherit systemSettings;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = true;
        };
        overlays = [ ];
      };

      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        system = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit userSettings; };
                users.caimeo = import ./home;
              };
            }
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit (inputs) foundry;
            inherit (inputs) forester;
          };
        };
      };
    };

  inputs = {
    stylix.url = "github:danth/stylix";
    forester = {
      url = "sourcehut:~jonsterling/ocaml-forester";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    foundry.url = "github:shazow/foundry.nix/monthly";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

