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
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  font_size = 18.0,
  window_background_opacity = 0.8
}
'';
  };
}
