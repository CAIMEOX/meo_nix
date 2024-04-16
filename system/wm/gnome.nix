{ pkgs, ... }:

{
  programs.gnupg.agent.pinentryFlavor = "gnome3";

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
    gnomeExtensions.top-bar-organizer
  ];


  # Enable the X11 windowing system.
  services = {
    # Gnome3 config
    dbus.packages = [ pkgs.dconf ];
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

    # GUI interface
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";

      # Enable touchpad support.
      libinput.enable = true;

      # Enable the Gnome3 desktop manager
      displayManager.gdm.enable    = true;
      displayManager.gdm.wayland   = true; # screen-sharing is broken
      desktopManager.gnome.enable = true;
    };
  };
}
