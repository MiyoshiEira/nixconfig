{pkgs, ...}: {
  home.packages = with pkgs; [
    python3Full
    imath
    pystring
    conda
  ];
}
