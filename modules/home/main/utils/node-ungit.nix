{ config, pkgs, ...}:
{
 home.packages = with pkgs; [nodePackages.ungit];
}
