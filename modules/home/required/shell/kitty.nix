{
  inputs,
  systemSettings,
  lib,
  ...
}: {
  programs.kitty = lib.mkForce {
    enable = true;
    theme = "Catppuccin-Mocha";
    font.name = "CaskaydiaCove Nerd Font";
    font.size = 18;
    settings = {
    enable_audio_bell = false;
    background_opacity= "0.5";
    background_blur = 5;
    };
  };
}
