{
  programs.kitty = {
    enable = true;
    font = {
      size = 12;
      name = "Hack Nerd Font";
    };

    settings = {
      scrollback_lines = 10000;
      placement_strategy = "center";

      allow_remote_control = "yes";
      enable_audio_bell = "no";
      visual_bell_duration = "0.1";

      copy_on_select = "clipboard";

      selection_foreground = "none";
      selection_background = "none";

      # colors
      background_opacity = "1";
    };

    theme = "Catppuccin-Mocha";
  };
}
