{ config, pkgs, userSettings, ... }:
{
imports = [
./brave.nix
./wm/hyprland/hyprland.nix
./wm/input/nihongo.nix
./style/networkmanager-dmenu.nix
./style/stylix.nix
./shell/cli-collection.nix
./shell/sh.nix
./shell/git.nix
./shell/lvim.nix
./shell/tmux.nix
./shell/kitty.nix
./shell/lf.nix
./security/sops.nix
./emacs/doom.nix
./security/keepass.nix
./hardware/kanshi.nix
./hardware/bluetooth.nix
./hardware/virtualization.nix
];
home.packages = with pkgs; [wl-clipboard isync mu];
}
