{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [texinfo];
}
