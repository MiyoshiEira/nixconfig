{
  description = "Flake";
  inputs = {

    #nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    #home-manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix = {
    url = "github:Mic92/sops-nix";
    };

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


    phscroll = {
      url = "github:misohena/phscroll";
      flake = false;
    };

    stylix.url = "github:danth/stylix";

    rust-overlay.url = "github:oxalica/rust-overlay";

  };
  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      # ---- SYSTEM SETTINGS ---- #
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
        username = "miyoshieira"; # username
        name = "MiyoshiEira"; # name/identifier
        email = "eira@miyoshi.app"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        theme = "uwunicorn-yt"; # selcted theme from my themes directory (./themes/)
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        browser = "brave"; # Default browser; must select one from ./user/app/browser/
        term = "kitty"; # Default terminal command;
        font = "Intel One Mono"; # Selected font
        fontPkg = pkgs.intel-one-mono; # Font package
        editor = "lvim"; # Default editor;
        spawnEditor = "lvim";
      };
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;

      pkgs = import inputs.nixpkgs {
        inherit (systemSettings) system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };

      home-manager = inputs.home-manager;
      #TODO IMPLEMENT CONFIGWIDE SETTINGS
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;
    in {
      inherit lib;
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix") # load home.nix from selected PROFILE
          ];
          extraSpecialArgs = {
            inherit pkgs;
            inherit systemSettings;
            inherit userSettings;
            inherit inputs outputs;
          };
        };
      };
      nixosConfigurations = {
        system = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
            ./system/bin/helper.nix
          ];
          specialArgs = {
            inherit pkgs;
            inherit systemSettings;
            inherit userSettings;
            inherit inputs outputs;
          };
        };
      };
    };
}
