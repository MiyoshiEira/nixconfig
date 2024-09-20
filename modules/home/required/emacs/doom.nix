{ config, lib, pkgs, pkgs-stable, ... }: {
  imports = [
    ../shell/sh.nix
    ../shell/cli-collection.nix
    ../shell/python.nix
    ../shell/pythonPackages.nix
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  home.packages = with pkgs; [
    (pkgs.mu.override { emacs = emacs29-pgtk; })
    emacsPackages.mu4e
    editorconfig-core-c
    emacs-all-the-icons-fonts
    nixfmt-classic
    wmctrl
    jshon
    nodejs

    (pkgs.makeDesktopItem {
      name = "doomemacs";
      desktopName = "Doom Emacs";
      exec = "emacs -c";
      terminal = false;
      type = "Application";
      icon = "emacs";
      mimeTypes = [ "application/octet-stream" ];
    })
  ];
  xdg.configFile."/.config/doom/doom.org".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/configs/doom.d/doom.org";
  xdg.configFile."/.config/doom/config.el".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/configs/doom.d/config.el";
  xdg.configFile."/.config/doom/init.el".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/configs/doom.d/init.el";
  xdg.configFile."/.config/doom/packages.el".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/configs/doom.d/packages.el";
}
