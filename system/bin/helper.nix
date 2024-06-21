{ pkgs, userSettings, ... }:
let helperScript = ''
      if [ "$1" = "sync" ]; then
          echo "Rebuilding System and User dirs";
          cd ~/ && nh os switch -H system;
          cd ~/ && nh home switch -c user && cd ~/.dotfiles;
          echo "reloading some stuff";
          pgrep Hyprland &> /dev/null && echo "Reloading hyprland" && hyprctl reload &> /dev/null;
          pgrep .waybar-wrapped &> /dev/null && echo "Restarting waybar" && killall .waybar-wrapped && echo "Running waybar" && waybar &> /dev/null & disown;
          pgrep fnott &> /dev/null && echo "Restarting fnott" && killall fnott && echo "Running fnott" && fnott &> /dev/null & disown;
          pgrep hyprpaper &> /dev/null && echo "Reapplying background via hyprpaper" && killall hyprpaper && echo "Running hyprpaper" && hyprpaper &> /dev/null & disown;
          exit 0;
        fi
    '';
in
{
  environment.systemPackages = [
    (pkgs.writeScriptBin "helper" helperScript)
  ];
}
