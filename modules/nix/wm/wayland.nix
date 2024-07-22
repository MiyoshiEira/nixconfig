{ config, pkgs, ... }: {
  imports = [ ./pipewire.nix ./dbus.nix ./gnome-keyring.nix ./fonts.nix ];

  environment.systemPackages = with pkgs; [ wayland waydroid ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "se";
      variant = "";
      options = "caps:escape";
    };
  };
}
