{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [lshw];
}
