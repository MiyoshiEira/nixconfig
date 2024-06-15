{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs;
      [
        tmuxPlugins.better-mouse-mode
      ];
    extraConfig = ''
    set -s escape-time 10
    set -sg repeat-time 600
    set -s focus-events on
    set -g prefic2 C-a
    bind C-a send-prefix -2
    set -q -g status-utf8 on
    setw -q -g utf8 on
    set -g history-limit 5000

    set -g base-index 1
    setw -g pane-base-index 1

    setw -g automatic-rename on
    set -g renumber-windows on

    set -g set-titles on
    set -g status-interval 10

    bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

    set -g monitor-activity on
    set -g visual-activity off


    bind - split-window -v
    bind _ split-window -h

    bind -r H resize-pane -L 2
    bind -r J resize-pane -D 2
    bind -r K resize-pane -U 2
    bind -r L resize-pane -R 2

    unbind n
    unbind p

    bind b list-buffers
    bind p paste-buffer -p
    bind P choose-buffer


    tmux_conf_copy_to_os_clipboard=true

    set -g mouse on

    '';
  };
}
