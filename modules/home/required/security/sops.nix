{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  home.packages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = ../../../../secrets/secrets.yaml;
    age.keyFile = "/home/miyoshieira/.config/sops/age/keys.txt";
    secrets."gitconf" = {
      path = "${config.home.homeDirectory}/.ssh/config";
      mode = "0600";
    };
    secrets."nixgit" = {
      path = "${config.home.homeDirectory}/.ssh/nixgit";
      mode = "0600";
    };
    secrets."wkey" = {
      path = "${config.home.homeDirectory}/.ssh/wkey";
      mode = "0600";
    };
    secrets."wprod" = {
      path = "${config.home.homeDirectory}/.ssh/wprod";
      mode = "0600";
    };
    secrets."cdn" = {
      path = "${config.home.homeDirectory}/Documents/scripts/waylandscreenshot.sh";
      mode = "0500";
    };
    secrets."msync" = {
      path = "${config.home.homeDirectory}/.mbsyncrc";
      mode = "0600";
    };
    secrets."m4" = {
      path= "${config.home.homeDirectory}/.config/doom/private.el";
      mode = "0600";
    };
    secrets."eauth" = {
    path = "${config.home.homeDirectory}/.msmtprc";
    mode = "0600";
    };
  };
}
