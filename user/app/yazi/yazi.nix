{ pkgs, config, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true; 

  };

home.file."${config.home.homeDirectory}/.config/yazi/yazi.toml".source = ../../../configs/yazi/yazi.toml;
home.file."${config.home.homeDirectory}/.config/yazi/keymap.toml".source = ../../../configs/yazi/keymap.toml;

}

