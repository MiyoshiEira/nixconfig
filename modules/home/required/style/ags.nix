{ config, lib, pkgs, inputs, ... }:

{
imports = [ inputs.ags.homeManagerModules.default  ];

programs.ags = {
  enable = true;

};
}
