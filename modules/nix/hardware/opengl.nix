{pkgs, ...}: {
  # OpenGL
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [];
}
