{ pkgs, ... }:




{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}";
    terminal = "tmux-256color";
    historyLimit = 100000;
    #plugins = with pkgs;
    #  [
    #    {
    #      plugin = tmux-super-fingers;
    #      extraConfig = "set -g @super-fingers-key f";
    #    }
    #    tmuxPlugins.better-mouse-mode
    #  ];
    extraConfig = ''
    '';
  };
}
