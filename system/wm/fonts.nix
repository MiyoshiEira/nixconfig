{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    noto-fonts-cjk
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerdfonts
  ];

}
