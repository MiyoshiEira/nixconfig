{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}: let
  themePath = "../../../../../themes" + ("/" + userSettings.theme + "/" + userSettings.theme) + ".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../../../themes" + ("/" + userSettings.theme) + "/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../../../themes" + ("/" + userSettings.theme) + "/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../../../themes/" + ("/" + userSettings.theme) + "/backgroundsha256.txt");
in {
  imports = [inputs.stylix.homeManagerModules.stylix];

  home.file.".currenttheme".text = userSettings.theme;
  stylix.autoEnable = false;
  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
  stylix.base16Scheme = ./. + themePath;

  stylix.fonts = {
    monospace = {
      name = "Noto CJK";
      package = pkgs.noto-fonts-cjk;
    };
    serif = {
      name = "Noto Serif";
      package = pkgs.noto-fonts-cjk;
    };
    sansSerif = {
      name = "Noto Sans Serif";
      package = pkgs.noto-fonts-cjk;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
    sizes = {
      terminal = 18;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
  };

  stylix.targets.kde.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.rofi.enable = false;
  stylix.targets.feh.enable = false;
  programs.feh.enable = true;
  home.file.".fehbg-stylix".text =
    ''
      #!/bin/sh
      feh --no-fehbg --bg-fill ''
    + config.stylix.image
    + ''      ;
    '';
  home.file.".fehbg-stylix".executable = true;
  home.file = {
    ".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ../../../../configs/assets/oomox-current.conf.mustache;
      extension = ".conf";
    };
    ".config/Trolltech.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ../../../../configs/assets/Trolltech.conf.mustache;
      extension = ".conf";
    };
    ".config/kdeglobals".source = config.lib.stylix.colors {
      template = builtins.readFile ../../../../configs/assets/Trolltech.conf.mustache;
      extension = "";
    };
    ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ../../../../configs/assets/qt5ct.conf);
  };
  home.file.".config/hypr/hyprpaper.conf".text =
    ''
      preload = ''
    + config.stylix.image
    + ''

      wallpaper = ,''
    + config.stylix.image
    + ''

    '';
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    pkgs.libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
  ];
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
    platformTheme.name = "kde";
  };
}
