{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ranger];
}