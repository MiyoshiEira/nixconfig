{ pkgs, ... }: {
  home.packages = with pkgs; [ adwaita-icon-theme nautilus gnome-calendar ];
}
