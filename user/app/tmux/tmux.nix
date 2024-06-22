{ pkgs, ... }:

{

  home.packages = with pkgs; [
  tmux
  ];

  programs.tmux = {
  enable = true;
  shell  = "${pkgs.zsh}/bin/zsh";
  keyMode = "vi";
  mouse = true;

};
}
