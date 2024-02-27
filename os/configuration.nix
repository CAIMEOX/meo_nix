{ config, pkgs, lib, systemSettings, userSettings, ... }:

{
  imports = [
    ./zone
    ./virtualisation
    ./wm/fonts.nix
    ./wm/dbus.nix
    ./wm/gnome.nix
    ./hardware
  ];

  # Bootloader.
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  # boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "AdisonCavani";
      repo = "distro-grub-themes";
      rev = "v3.1";
      hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
    };
    installPhase = "cp -r customize/nixos $out";
  };

  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
  networking.firewall = {
   enable = true;
   allowedUDPPortRanges = [ {from = 5000; to = 6000; } ];
   allowedTCPPortRanges = [ {from = 5000; to = 6000; } ];
  };


  nix.settings = { 
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  services.flatpak.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  
  users.users.${userSettings.username} = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = userSettings.name;
    packages = [];
    extraGroups = [ "networkmanager" "wheel" ];
  };


  environment.systemPackages = with pkgs; [
    (
      let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
        name = "fhs";
        targetPkgs = pkgs: (
          (base.targetPkgs pkgs) ++ [
            pkgs.pkg-config
            pkgs.ncurses
          ]
        );
        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = [ "dev" ];
      })
    )
    gcc
    vim
    wget
    clang
    home-manager
  ];

  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [
  #    pkgs.xdg-desktop-portal
  #    pkgs.xdg-desktop-portal-gtk
  #  ];
  #};

  system.stateVersion = "24.05";
}
