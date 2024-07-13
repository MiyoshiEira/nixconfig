{
  inputs,
  pkgs,
  lib,
  systemSettings,
  ...
}: {
  programs.wezterm = {
  enable = true;
  package = inputs.wezterm.packages.${systemSettings.system}.default;
  };
}
