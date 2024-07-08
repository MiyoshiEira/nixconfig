{
  config,
  pkgs,
  lib,
  userSettings,
  ...
}: {
  home.packages = with pkgs; [lunarvim];

  home.file.".config/lvim" = {
    source = ../../../../configs/lvim/after;
    recursive = true;
  };
  home.file.".config/lvim/ftdetect" = {
    source = ../../../../configs/lvim/ftdetect;
    recursive = true;
  };
  home.file.".config/lvim/ftplugin" = {
    source = ../../../../configs/lvim/ftplugin;
    recursive = true;
  };
  home.file.".config/lvim/lsp-settings" = {
    source = ../../../../configs/lvim/lsp-settings;
    recursive = true;
  };
  home.file.".config/lvim/lua" = {
    source = ../../../../configs/lvim/lua;
    recursive = true;
  };
  home.file.".config/lvim/snippets" = {
    source = ../../../../configs/lvim/snippets;
    recursive = true;
  };
  home.file.".config/lvim/.java-google-formatter.xml" = {
    source = ../../../../configs/lvim/.java-google-formatter.xml;
  };
  home.file.".config/lvim/.luacheckrc" = {
    source = ../../../../configs/lvim/.luacheckrc;
  };
  home.file.".config/lvim/.luarc.json" = {
    source = ../../../../configs/lvim/.luarc.json;
  };
  home.file.".config/lvim/.markdownlint.json" = {
    source = ../../../../configs/lvim/.markdownlint.json;
  };
  home.file.".config/lvim/.stylua.toml" = {
    source = ../../../../configs/lvim/.stylua.toml;
  };
  home.file.".config/lvim/config.lua" = {
    source = ../../../../configs/lvim/config.lua;
  };
  home.file.".config/lvim/LICENSE" = {
    source = ../../../../configs/lvim/LICENSE;
  };
  home.file.".config/lvim/README.md" = {
    source = ../../../../configs/lvim/README.md;
  };
  home.file.".config/lvim/selene.toml" = {
    source = ../../../../configs/lvim/selene.toml;
  };
  home.file.".config/lvim/task_template.ini" = {
    source = ../../../../configs/lvim/task_template.ini;
  };
  home.file.".config/lvim/tasks.ini" = {
    source = ../../../../configs/lvim/tasks.ini;
  };
  home.file.".config/lvim/vale_config.ini" = {
    source = ../../../../configs/lvim/vale_config.ini;
  };
  home.file.".config/lvim/vim.toml" = {
    source = ../../../../configs/lvim/vim.toml;
  };
}
