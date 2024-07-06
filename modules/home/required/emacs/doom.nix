{ config, lib, pkgs, userSettings, ... }:

{
programs.doom-emacs = {
  emacs = pkgs.emacs29-pgtk;
  enable = true;
  doomDir = ../../../../configs/doom.d;
  extraPackages = epkgs: [ epkgs.python epkgs.treesit-grammars.with-all-grammars ];
};
services.emacs.enable = true;

}
