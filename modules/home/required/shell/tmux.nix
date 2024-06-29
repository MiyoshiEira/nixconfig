{ pkgs, config, lib, ... }:

{

  home.packages = with pkgs; [
  tmux
  ];

  programs.tmux = {
  enable = true;
  shell  = "${pkgs.zsh}/bin/zsh";
  extraConfig  = '''';
};



xdg.configFile."tmux/tmux.conf".source = ../../../../configs/tmux/tmux.conf;
xdg.configFile."tmux/tmux.conf.local".source = ../../../../configs/tmux/tmux.conf.local;

}
