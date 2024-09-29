{
  description = "Flake";
  inputs = {
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    ags.url = "github:Aylur/ags";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    stylix.url = "github:danth/stylix";
    systems.url = "github:nix-systems/default-linux";
  };
  outputs = {
    self,
    nixpkgs,
    lix-module,
    home-manager,
    systems,
    catppuccin,
    nixpkgs-stable,
    zen-browser,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    lib = nixpkgs.lib // home-manager.lib;
    pkgsFor = lib.genAttrs (import systems) (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
overlays = [ (final: prev: {
      vintagestory = prev.vintagestory.overrideAttrs (old: {
        preFixup = builtins.replaceStrings
          ["--prefix LD_LIBRARY_PATH"]
          ["--set LD_PRELOAD ${final.xorg.libXcursor}/lib/libXcursor.so.1 --prefix LD_LIBRARY_PATH"]
          old.preFixup;
      });
    })];
  });
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};


    # ---- SYSTEM SETTINGS ---- # TODO discontinue central configuration inside of flake
    systemSettings = {
      system = "x86_64-linux"; # system arch
      hostname = "nixos"; # hostname
      profile = "personal";
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
      wmType =
        if (wm == "hyprland")
        then "wayland"
        else "x11";
      browser = "zen";
      term = "kitty";
      editor = "lvim";
      spawnEditor =
        if (editor == "emacs")
        then "emacsclient -c 'emacs'"
        else
          (
            if (editor == "lvim")
            then "exec " + term + " -c " + editor
            else editor
          );
    };
  in {
    inherit lib;
    homeConfigurations = {
      user = lib.homeManagerConfiguration {
        modules = [
          catppuccin.homeManagerModules.catppuccin
          (./.
            + "/hosts"
            + ("/" + systemSettings.profile)
            + "/home.nix") # load home.nix from selected PROFILE
        ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs outputs;
          inherit zen-browser;
          inherit pkgs-stable;
        };
      };
    };
    nixosConfigurations = {
      system = lib.nixosSystem {
        modules = [
          lix-module.nixosModules.default
          (./.
            + "/hosts"
            + ("/" + systemSettings.profile)
            + "/configuration.nix")
          ./modules/nix/bin/helper.nix
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs outputs;
          inherit pkgs-stable;
        };
      };
    };
  };
}
