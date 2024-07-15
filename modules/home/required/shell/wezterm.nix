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
  extraConfig = ''
  return {
  color_scheme = "Catppuccin Mocha"
  }
'';
  };
}
