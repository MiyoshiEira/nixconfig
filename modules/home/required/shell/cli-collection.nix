{pkgs, ...}: {
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # Command Line
    lolcat
    cowsay
    cava
    killall
    libnotify
    timer
    brightnessctl
    gnugrep
    bat
    eza
    fd
    bottom
    ripgrep
    rsync
    unzip
    w3m
    pandoc
    hwinfo
    pciutils
    numbat
    selene
    deadnix
    (pkgs.writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          nmcli n off
      else
          nmcli n on
      fi
    '')
    vim
    neovim
    fastfetch
  ];
}
