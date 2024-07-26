{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ satty ];

  xdg.configFile."/.config/satty/config.toml".source =
    "${config.home.homeDirectory}/.dotfiles/configs/satty/config.toml";
}
