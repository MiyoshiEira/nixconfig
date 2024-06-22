{ pkgs, config, ... }:

{
  programs.yazi = {
    enable = true;
  };

home.file."${config.home.homeDirectory}/.config/yazi/yazi.toml".source = ../../../configs/yazi/yazi.toml;

}

