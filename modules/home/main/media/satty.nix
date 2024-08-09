{pkgs, ...}: {
  home.packages = with pkgs; [satty];

  xdg.configFile."/.config/satty/config.toml".source =
    ../../../../configs/satty/config.toml;
}
