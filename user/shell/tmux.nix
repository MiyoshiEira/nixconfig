{ pkgs, ... }:




{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    clock24 = true;
    #plugins = with pkgs;
    #  [
    #    {
    #      plugin = tmux-super-fingers;
    #      extraConfig = "set -g @super-fingers-key f";
    #    }
    #    tmuxPlugins.better-mouse-mode
    #  ];
    extraConfig = ''



%if #{==:#{TMUX_PROGRAM},}
  run 'TMUX_PROGRAM="$(LSOF=$(PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" command -v lsof); $LSOF -b -w -a -d txt -p #{pid} -Fn 2>/dev/null | perl -n -e "if (s/^n((?:.(?!dylib$|so$))+)$/\1/g && s/(?:\s+\([^\s]+?\))?$//g) { print; exit } } exit 1; {" || readlink "/proc/#{pid}/exe" 2>/dev/null)"; {[ -f "$TMUX_PROGRAM" ] && [ -x "$TMUX_PROGRAM" ]} || TMUX_PROGRAM="$(command -v tmux || printf tmux)"; "$TMUX_PROGRAM" -S #{socket_path} set-environment -g TMUX_PROGRAM "$TMUX_PROGRAM"'
%endif
%if #{==:#{TMUX_SOCKET},}
  run '"$TMUX_PROGRAM" -S #{socket_path} set-environment -g TMUX_SOCKET "#{socket_path}"'
%endif
%if #{==:#{TMUX_CONF},}
  run '"$TMUX_PROGRAM" set-environment -g TMUX_CONF $(for conf in "$HOME/.tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"; do [ -f "$conf" ] && printf "%s" "$conf" && break; done)'
%endif
%if #{==:#{TMUX_CONF_LOCAL},}
  run '"$TMUX_PROGRAM" set-environment -g TMUX_CONF_LOCAL "$TMUX_CONF.local"'
%endif


run '"$TMUX_PROGRAM" source "$TMUX_CONF_LOCAL"'
run 'cut -c3- "$TMUX_CONF" | sh -s _apply_configuration'


    set -g default-terminal "screen-256color"
    setw -g xterm-keys on
    set -s escape-time 10                     # faster command sequences
    set -sg repeat-time 600                   # increase repeat timeout
    set -s focus-events on
    set -g prefix2 C-a                        # GNU-Screen compatible prefix
    bind C-a send-prefix -2
    set -q -g status-utf8 on                  # expect UTF-8 (tmux < 2.2)
    setw -q -g utf8 on
    set -g history-limit 5000

    set -g base-index 1           # start windows numbering at 1
    setw -g pane-base-index 1     # make pane numbering consistent with windows

    setw -g automatic-rename on   # rename window to reflect current program
    set -g renumber-windows on    # renumber windows when a window is closed

    set -g set-titles on          # set terminal title

    set -g display-panes-time 800 # slightly longer pane indicators display time
    set -g display-time 1000      # slightly longer status messages display time

    set -g status-interval 10     # redraw status line every 10 seconds

    # clear both screen and history
    bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

    # activity
    set -g monitor-activity on
    set -g visual-activity off


# -- navigation ----------------------------------------------------------------

   # create session
   bind C-c new-session

   # find session
   bind C-f command-prompt -p find-session 'switch-client -t %%'

   # session navigation
   bind BTab switch-client -l  # move to last session

   # split current window horizontally
   bind - split-window -v
   # split current window vertically
   bind _ split-window -h

   # pane navigation
   bind -r h select-pane -L  # move left
   bind -r j select-pane -D  # move down
   bind -r k select-pane -U  # move up
   bind -r l select-pane -R  # move right
   bind > swap-pane -D       # swap current pane with the next one
   bind < swap-pane -U       # swap current pane with the previous one

   # maximize current pane
   bind + run "cut -c3- '#{TMUX_CONF}' | sh -s _maximize_pane '#{session_name}' '#D'"

   # pane resizing
   bind -r H resize-pane -L 2
   bind -r J resize-pane -D 2
   bind -r K resize-pane -U 2
   bind -r L resize-pane -R 2

   # window navigation
   unbind n
   unbind p
   bind -r C-h previous-window # select previous window
   bind -r C-l next-window     # select next window
   bind Tab last-window        # move to last active window

   # toggle mouse
   bind m run "cut -c3- '#{TMUX_CONF}' | sh -s _toggle_mouse"

    
    '';
  };
}
