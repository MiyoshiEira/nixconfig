{ config, pkgs, userSettings, ... }:
{
imports = [
./brave.nix
./wm/hyprland/hyprland.nix
./wm/input/nihongo.nix
./style/networkmanager-dmenu.nix
./style/stylix.nix
./shell/sh.nix
./shell/git.nix
./shell/lvim.nix
./shell/tmux.nix
./shell/kitty.nix
./shell/selene.nix
./shell/deadnix.nix
./shell/ranger.nix
./security/sops.nix
./security/keepass.nix
./hardware/kanshi.nix
./hardware/bluetooth.nix
./hardware/virtualization.nix
];

programs.doom-emacs = {
    emacs = pkgs.emacs29-pgtk;
    enable = true;
    doomDir = ../../../configs/doom.d;
    extraPackages = epkgs: [ epkgs.python epkgs.treesit-grammars.with-all-grammars ];
};

services.emacs.enable = true;

  home.file.".local/share/pixmaps/nixos-snowflake-stylix.svg".source =
  config.lib.stylix.colors {
  template = builtins.readFile ../../../configs/assets/nixos-snowflake-stylix.svg.mustache;
  extension = "svg";
  };

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
  xdg.mimeApps.associations.added = {
  };

  home.sessionVariables = {
  EDITOR = userSettings.editor;
  SPAWNEDITOR = userSettings.spawnEditor;
  TERM = userSettings.term;
  BROWSER = userSettings.browser;
  };

  news.display = "silent";
}

