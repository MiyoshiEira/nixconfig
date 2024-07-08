{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  programs.doom-emacs = {
    emacs = pkgs.emacs29-pgtk;
    enable = true;
    doomDir = ../../../../configs/doom.d;
    extraPackages = epkgs: [epkgs.python epkgs.treesit-grammars.with-all-grammars epkgs.mu4e];
  };
  home.packages = with pkgs; [
    isync
    (pkgs.mu.override {emacs = emacs29-pgtk;})
    emacsPackages.mu4e
  ];
  services.emacs.enable = true;
}
