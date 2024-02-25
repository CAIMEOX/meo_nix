{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "fish";
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
        startup_mode = "Maximized";
      };

      scrolling.history = 10000;

      font = {
        normal.family = "JetBrains Mono";
        bold.family = "JetBrains Mono";
        italic.family = "JetBrains Mono";
        size = 12;
      };
      
      colors = {
        draw_bold_text_with_bright_colors = true;
      };

      window.opacity = 0.9;
    };
  };
}
