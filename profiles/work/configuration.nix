# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  config,
  lib,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    ../shared/shared-system.nix
    ./hardware-configuration.nix
  ];
}
