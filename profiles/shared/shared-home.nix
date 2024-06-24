{ config, pkgs, userSettings, ... }:


{
imports = [ 
              (./. + "../../../user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix")
              ../../user/shell/sh.nix
              ../../user/shell/cli-collection.nix
              ../../user/app/git/git.nix
              ../../user/app/keepass/keepass.nix
              (./. + "../../../user/app/browser"+("/"+userSettings.browser)+".nix")
              ../../user/app/virtualization/virtualization.nix
              ../../user/style/stylix.nix
              ../../user/lang/cc/cc.nix
              ../../user/hardware/bluetooth.nix
              ../../user/security/sops.nix
              ../../user/app/lf/lf.nix
              ../../user/app/tmux/tmux.nix
              ../../user/hardware/kanshi.nix
            ];
  home.packages = with pkgs; [
    # Core
    brave
    calibre
    vesktop
    ani-cli
    protonup-qt
    filezilla
    qbittorrent
    veracrypt

    # Utils
    easyeffects
    xclip
    jq
    lazygit
    file
    swappy
    git
    syncthing
    yubikey-manager-qt
    nextcloud-client
    thunderbird
    lunarvim
    lshw
    comma
    nix-index

    # Office
    libreoffice-fresh
    gnome.adwaita-icon-theme
    shared-mime-info
    glib
    gnome.nautilus
    gnome.gnome-calendar
    texliveSmall

    # Media
    gimp
    krita
    vlc
    mpv
    yt-dlp
    blender-hip
    obs-studio
    ffmpeg
    mediainfo
    libmediainfo
    audio-recorder

    # Misc Dev
    texinfo
    libffi zlib
    nodePackages.ungit
    ventoy
    python3
    nix-init
    statix
    
    
];

  #LunarVim config
  xdg.configFile."lvim/config.lua".source = ../../configs/lvim/config.lua;
  xdg.configFile."lvim/lazy-lock.json".source = ../../configs/lvim/lazy-lock.json;


  home.file.".local/share/pixmaps/nixos-snowflake-stylix.svg".source =
  config.lib.stylix.colors {
  template = builtins.readFile ../../user/pkgs/nixos-snowflake-stylix.svg.mustache;
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