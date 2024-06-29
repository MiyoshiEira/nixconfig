{
  description = "Flake";
  inputs = {

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      allRefs= true;
      rev = "7230fe53cf3cabc9be8821784fb79507fee4c9e9";
    };
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins/151102b7d7c4f61ff42f275e72008d28318dac96";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hycov.url = "github:DreamMaoMao/hycov/3d144a79f8b5468656de88a005be55f3317d295b";
    hycov.inputs.hyprland.follows = "hyprland";
    stylix.url = "github:danth/stylix";
    systems.url = "github:nix-systems/default-linux";

  };
  outputs = { self, nixpkgs, lix-module, home-manager, systems, ... } @ inputs:
    let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
      # ---- SYSTEM SETTINGS ---- # TODO discontinue central configuration inside of flake
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos"; # hostname
        profile = "personal"; # select a profile defined from my profiles directory
        timezone = "Europe/Stockholm"; # select timezone
        locale = "en_US.UTF-8"; # select locale
        bootMode = "uefi"; # uefi or bios
        bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
        grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
      };

      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "miyoshieira";
        name = "MiyoshiEira";
        email = "eira@miyoshi.app";
        dotfilesDir = "~/.dotfiles";
        theme = "uwunicorn-yt";
        wm = "hyprland";
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        browser = "brave";
        term = "kitty";
        editor = "lvim";
        spawnEditor = "lvim";
      };

    in {
    inherit lib;
      homeConfigurations = {
        user = lib.homeManagerConfiguration {
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix") # load home.nix from selected PROFILE
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs outputs;
          };
        };
      };
      nixosConfigurations = {
        system = lib.nixosSystem {
          modules = [
            lix-module.nixosModules.default
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
            ./system/bin/helper.nix
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs outputs;
          };
        };
      };
    };
}
