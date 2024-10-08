{pkgs, ...}: {
  # Fonts are nice to have
  fonts = {
    packages = with pkgs; [
      # Fonts
      noto-fonts-cjk
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
      roboto
      roboto-slab
      roboto-mono
      roboto-serif
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Fonts CJK Serif"];
        sansSerif = ["Noto Fonts CJK Sans"];
        monospace = ["Noto Fonts CJK"];
      };
    };
  };
}
