{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {

  imports = [
  ../shell/sh.nix
  ../shell/cli-collection.nix
  ];

  home.packages = with pkgs; [
    msmtp
    isync
    emacs29-pgtk
    (pkgs.mu.override {emacs = emacs29-pgtk;})
    emacsPackages.mu4e
    binutils
    gnutls
    fd
    imagemagick
    fd
    zstd
    nodePackages.javascript-typescript-langserver
    sqlite
    editorconfig-core-c
    emacs-all-the-icons-fonts
    (pkgs.makeDesktopItem {
      name = "doomemacs";
      desktopName = "Doom Emacs";
      exec = "emacsclient -c";
      terminal = false;
      type = "Application";
      icon = "emacs";
      mimeTypes = ["application/octet-stream"];
    })
  ];
  services.emacs.enable = true;
  xdg.configFile."/.config/doom/doom.org".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/doom.org";
  xdg.configFile."/.config/doom/config.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/config.el";
  xdg.configFile."/.config/doom/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/init.el";
  xdg.configFile."/.config/doom/packages.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom.d/packages.el";
}
