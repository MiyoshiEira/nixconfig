{ config, pkgs, lib, userSettings, inputs, ... }: {
  imports = [ ../../modules/home/required ../../modules/home/main ];

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.pointerCursor = {
    enable = true;
    flavor = "mocha";
    accent = "red";
  };
  gtk.catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "red";
    icon.enable = true;
    icon.accent = "red";
    icon.flavor = "mocha";
  };
  i18n.inputMethod.fcitx5.catppuccin.apply = true;
  i18n.inputMethod.fcitx5.catppuccin.flavor = "mocha";

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
      XDG_GAME_DIR = "${config.home.homeDirectory}/Media/Games";
      XDG_GAME_SAVE_DIR = "${config.home.homeDirectory}/Media/Game Saves";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = { };
}
