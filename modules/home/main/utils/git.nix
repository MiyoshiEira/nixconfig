{pkgs, ...}: {
  home.packages = with pkgs; [git];
}
