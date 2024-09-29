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
    extraConfig = ''
if [[ -z "$TMUX" ]]; then
    if tmux has-session 2>/dev/null; then
        exec tmux attach
    else
        exec tmux
    fi
fi
    '';
    settings = {
    enable_audio_bell = false;
    background_opacity= "0.5";
    background_blur = 5;
    };
  };
}
