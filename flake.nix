{
  description = "Meo NixOS configuration";

  outputs =
    { self
    , home-manager
    , nixpkgs
    , stylix
    , hyprland-plugins
    , ...
    }@inputs:

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
        spawnEditor = if (editor == "emacsclient") then "emacsclient -c -a 'emacs'"
                    else (if ((editor == "vim") || (editor == "nvim") || (editor == "nano")) then "exec " + term + " -e " + editor else editor);
        browser = "google-chrome-stable";
      };

      systemSettings = {
        system = "x86_64-linux";
        hostname = "meo";
        profile = "meo";
        timezone = "Asia/Shanghai";
        locale = "en_US.UTF-8";
      };

      pkgs = (import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        overlays = [ ];
      });

      lib = nixpkgs.lib;
      
    in
    {
      nixosConfigurations = {
        system = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./os/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit userSettings;
              };
              home-manager.users.caimeo = import ./home;
            }
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit (inputs) stylix;
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
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

