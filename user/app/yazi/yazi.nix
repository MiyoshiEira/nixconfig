{ pkgs, config, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    flavors = {};
    #initLua = {};
    keymap = {};
    plugins = {};
    settings = {};
    theme = {};

  };

#home.file."${config.home.homeDirectory}/.config/yazi/yazi.toml".source = ../../../configs/yazi/yazi.toml;

}

