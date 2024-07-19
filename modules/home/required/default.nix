{
  config,
  pkgs,
  userSettings,
  ...
}: {
  imports = [
    ./brave.nix
    ./qutebrowser.nix
    ./wm/hyprland/hyprland.nix
    ./wm/input/nihongo.nix
    ./style/networkmanager-dmenu.nix
    ./style/stylix.nix
    ./shell/cli-collection.nix
    ./shell/sh.nix
    ./shell/git.nix
    ./shell/lvim.nix
    ./shell/wezterm.nix
    ./shell/python.nix
    ./shell/pythonPackages.nix
    ./security/sops.nix
    ./emacs/doom.nix
    ./security/keepass.nix
    ./hardware/kanshi.nix
    ./hardware/bluetooth.nix
    ./hardware/virtualization.nix
  ];
  home.packages = with pkgs; [wl-clipboard fzf];
}
