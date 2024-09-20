{
  pkgs,
  lib,
  config,
  ...
}: {

home.packages = with pkgs; [glances];

xdg.configFile."/.config/glances/glances.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/glances/glances.conf";
}
