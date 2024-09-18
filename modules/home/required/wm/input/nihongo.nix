{ pkgs, ... }: {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
  };
  home.file.".config/fcitx5/config".text = ''
    [Hotkey]
    # Enumerate when press trigger key repeatedly
    EnumerateWithTriggerKeys=True
    # Temporally switch between first and current Input Method
    AltTriggerKeys=
    # Enumerate Input Method Forward
    EnumerateForwardKeys=
    # Enumerate Input Method Backward
    EnumerateBackwardKeys=
    # Skip first input method while enumerating
    EnumerateSkipFirst=False
    # Toggle embedded preedit
    TogglePreedit=

    [Hotkey/TriggerKeys]
    0=Alt+Shift+Shift_L

    [Hotkey/EnumerateGroupForwardKeys]
    0=Super+space

    [Hotkey/EnumerateGroupBackwardKeys]
    0=Shift+Super+space

    [Hotkey/ActivateKeys]
    0=Hangul_Hanja

    [Hotkey/DeactivateKeys]
    0=Hangul_Romaja

    [Hotkey/PrevPage]
    0=Up

    [Hotkey/NextPage]
    0=Down

    [Hotkey/PrevCandidate]
  '';
}
