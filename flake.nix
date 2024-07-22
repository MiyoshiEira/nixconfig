{
  description = "Flake";
  inputs = {
    catppuccin.url = "github:catppuccin/nix";
    ags.url = "github:Aylur/ags";
    wezterm = { url = "github:wez/wezterm?dir=nix"; };
    lix-module = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
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
      rev = "918d8340afd652b011b937d29d5eea0be08467f5";
    };
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-plugins.url =
      "github:hyprwm/hyprland-plugins/3ae670253a5a3ae1e3a3104fb732a8c990a31487";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hycov.url =
      "github:DreamMaoMao/hycov/de15cdd6bf2e46cbc69735307f340b57e2ce3dd0";
    hycov.inputs.hyprland.follows = "hyprland";
    stylix.url = "github:danth/stylix";
    systems.url = "github:nix-systems/default-linux";
  };
  outputs = { self, nixpkgs, lix-module, home-manager, systems, catppuccin, ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      pkgsFor = lib.genAttrs (import systems) (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
      # ---- SYSTEM SETTINGS ---- # TODO discontinue central configuration inside of flake
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos"; # hostname
        profile = "personal";
        timezone = "Europe/Stockholm"; # select timezone
        locale = "en_US.UTF-8"; # select locale
        bootMode = "uefi"; # uefi or bios
        bootMountPath =
          "/boot"; # mount path for efi boot partition; only used for uefi boot mode
        grubDevice =
          ""; # device identifier for grub; only used for legacy (bios) boot mode
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
        term = "wezterm";
        editor = "emacs";
        spawnEditor = if (editor == "emacs") then
          "emacsclient -c 'emacs'"
        else
          (if (editor == "lvim") then
            "exec " + term + " -c " + editor
          else
            editor);
      };
    in {
      inherit lib;
      homeConfigurations = {
        user = lib.homeManagerConfiguration {
          modules = [
            catppuccin.homeManagerModules.catppuccin
            (./. + "/hosts" + ("/" + systemSettings.profile)
              + "/home.nix") # load home.nix from selected PROFILE
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
            (./. + "/hosts" + ("/" + systemSettings.profile)
              + "/configuration.nix")
            ./modules/nix/bin/helper.nix
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
