{pkgs, ...}: let
  # My shell aliases
  myAliases = {
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    htop = "btm";
    neofetch = "disfetch";
    fetch = "disfetch";
    gitfetch = "onefetch";
    cd = "z";
    nos = "cd ~/ && nh os switch -H system && cd ~/.dotfiles";
    nhome = "cd ~/ && nh home switch -c user && cd ~/.dotfiles";
    doom-sync = "~/.config/emacs/bin/doom sync";
  };
in {
  programs.zoxide = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
            export PATH="$PATH":"$HOME/.config/emacs/bin"
      if [[ -z "$TMUX" ]]; then
          if tmux has-session 2>/dev/null; then
              exec tmux attach
          else
              exec tmux
          fi
      fi
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
    disfetch
    lolcat
    cowsay
    onefetch
    gnugrep
    gnused
    bat
    eza
    bottom
    fd
    bc
    direnv
    nix-direnv
    inxi
    gcc
    libvterm
    libtool
    cmake
    msmtp
    isync
    binutils
    gnutls
    imagemagick
    zstd
    sqlite
    ripgrep
    nil
    nodePackages.javascript-typescript-langserver
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
