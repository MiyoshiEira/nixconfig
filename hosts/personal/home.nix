{
  config,
  pkgs,
  userSettings,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    ../global/shared-home.nix
  ];
  home.file.".local/share/pixmaps/nixos-snowflake-stylix.svg".source = config.lib.stylix.colors {
    template = builtins.readFile ../../configs/assets/nixos-snowflake-stylix.svg.mustache;
    extension = "svg";
  };

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

  news.display = "silent";
  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [discord via vintagestory rustdesk];
}
