{pkgs, ...}: {
  home.packages = with pkgs; [jdk22];
}
