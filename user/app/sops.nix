{ config, pkgs, lib, inputs, outputs, userSettings, systemSettings, ... }:

{
imports = [
 inputs.sops-nix.homeManagerModules.sops
 ];

home.packages = with pkgs; [
sops
];

sops = {
  defaultSopsFile = ../../secrets/secrets.yaml;
  age.keyFile = "/home/miyoshieira/.config/sops/age/keys.txt";
  secrets."gitconf" = {};
  };
}

