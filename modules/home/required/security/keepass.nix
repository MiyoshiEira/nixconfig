{pkgs, ...}: {
  home.packages = with pkgs; [
    keepassxc
    keepmenu
    yubikey-manager
  ];
}
