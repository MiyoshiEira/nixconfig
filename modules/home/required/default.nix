{
  pkgs,
  pkgs-stable,
  zen-browser,
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
    ./shell/kitty.nix
    ./shell/python.nix
    ./shell/pythonPackages.nix
    ./shell/glances.nix
    ./security/sops.nix
    ./emacs/doom.nix
    ./security/keepass.nix
    ./hardware/kanshi.nix
    ./hardware/bluetooth.nix
    ./hardware/virtualization.nix
  ];
  home.packages = with pkgs;
    [wl-clipboard fzf p7zip qdirstat lf zen-browser.packages."${system}".default ]
    ++ (with pkgs-stable; [
      orca-slicer
      blender
      prusa-slicer
    ]);
}
