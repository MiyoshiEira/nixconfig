{ config, pkgs, ...}:
{
 home.packages = with pkgs; [libmediainfo];
}
