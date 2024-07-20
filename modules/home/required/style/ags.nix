{ config, lib, pkgs, inputs, ... }:

{
imports = [ inputs.ags.homeManagerModules.default  ];

home.packages = with pkgs; [
  bun
  dart-sass
  matugen

];
programs.ags = {
  enable = true;
  configDir = ../../../../configs/ags;

};
}
