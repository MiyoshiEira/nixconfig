{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [qutebrowser];
  xdg.configFile."/.config/qutebrowser/config.py".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/qutebrowser/config.py";
}
