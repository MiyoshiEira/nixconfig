{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  home.packages = with pkgs; [
    isync
    emacs29-pgtk
    (pkgs.mu.override {emacs = emacs29-pgtk;})
    emacsPackages.mu4e
  ];
  services.emacs.enable = true;
  xdg.configFile."/.config/doom/doom.org".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/doom.org";
  xdg.configFile."/.config/doom/config.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/config.el";
  xdg.configFile."/.config/doom/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/init.el";
  xdg.configFile."/.config/doom/packages.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/packages.el";
}
