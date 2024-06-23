{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
  tmux
  ];

  programs.tmux = {
  enable = true;
  shell  = "${pkgs.zsh}/bin/zsh";
};
home.file."${config.home.homeDirectory}/.config/tmux/tmux.conf".source = ../../../configs/tmux/tmux.conf;
home.file."${config.home.homeDirectory}/.config/tmux/tmux.conf.local".source = ../../../configs/tmux/tmux.conf.local;

}
