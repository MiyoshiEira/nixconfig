{pkgs, ...}: {
  home.packages = with pkgs; [mediainfo];
}
