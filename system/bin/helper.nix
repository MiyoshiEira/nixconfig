{ pkgs, ... }:
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
      elif [ "$1" = "system" ]; then
          cd ~/ && nh os switch -H system;
          echo "reloading some stuff";
          pgrep Hyprland &> /dev/null && echo "Reloading hyprland" && hyprctl reload &> /dev/null;
          pgrep .waybar-wrapped &> /dev/null && echo "Restarting waybar" && killall .waybar-wrapped && echo "Running waybar" && waybar &> /dev/null & disown;
          pgrep fnott &> /dev/null && echo "Restarting fnott" && killall fnott && echo "Running fnott" && fnott &> /dev/null & disown;
          pgrep hyprpaper &> /dev/null && echo "Reapplying background via hyprpaper" && killall hyprpaper && echo "Running hyprpaper" && hyprpaper &> /dev/null & disown;
          exit 0;
      elif [ "$1" = "home" ]; then
          cd ~/ && nh home switch -c user && cd ~/.dotfiles;
          echo "reloading some stuff";
          pgrep Hyprland &> /dev/null && echo "Reloading hyprland" && hyprctl reload &> /dev/null;
          pgrep .waybar-wrapped &> /dev/null && echo "Restarting waybar" && killall .waybar-wrapped && echo "Running waybar" && waybar &> /dev/null & disown;
          pgrep fnott &> /dev/null && echo "Restarting fnott" && killall fnott && echo "Running fnott" && fnott &> /dev/null & disown;
          pgrep hyprpaper &> /dev/null && echo "Reapplying background via hyprpaper" && killall hyprpaper && echo "Running hyprpaper" && hyprpaper &> /dev/null & disown;
          exit 0;
      elif [ "$1" = "update" ]; then
          echo "Updating Flake";
          cd ~/.dotfiles && sudo nix flake update;
          exit 0;
      elif [ "$1" = "pull" ]; then
          echo "Pulling from Git";
          cd ~/.dotfiles;
          pushd ~/.dotfiles &> /dev/null;
          git stash;
          git pull;
          git stash apply;
          popd &> /dev/null;
          exit 0;
      elif [ "$1" = "gc" ]; then
      nh clean all -k 10;
      exit 0;      
      else
      echo "Specify sync, update, pull or gc"
      fi
    '';
in
{
  environment.systemPackages = [
    (pkgs.writeScriptBin "helper" helperScript)
  ];
}
