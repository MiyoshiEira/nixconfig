{ config, pkgs, ...}:
{
 home.packages = with pkgs; [notify-send];
}
