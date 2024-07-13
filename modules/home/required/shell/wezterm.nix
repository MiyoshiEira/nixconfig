{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
  ];
  programs.wezterm.enable = true;
  programs.wezterm.settings = {
    background_opacity = lib.mkForce "0.75";
  };
}
