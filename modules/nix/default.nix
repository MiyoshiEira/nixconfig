{ config, lib, pkgs, userSettings, ... }:

{
imports = [
./style/stylix.nix
./security/automount.nix
./security/firewall.nix
./security/gpg.nix
./security/sshd.nix
./wm/hyprland.nix
( import ./app/docker.nix {storageDriver = null; inherit pkgs userSettings lib;} )
./app/gamemode.nix
./app/obsidian.nix
./app/prismlauncher.nix
./app/steam.nix
./app/virtualization.nix
./bin/helper.nix
./hardware/bluetooth.nix
./hardware/kernel.nix
./hardware/opengl.nix
./hardware/power.nix
./hardware/printing.nix
./hardware/time.nix

];

}
