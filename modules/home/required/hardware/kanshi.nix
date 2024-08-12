{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ kanshi ];

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      {
        output = {
          criteria = "*";
          status = "enable";
        };
      }
      {
        profile = {
          name = "home";
          outputs = [
            {
              criteria = "DP-2";
              position = "0,0";
              mode = "2560x1440@143.91Hz";
              status = "enable";
            }
            {
              criteria = "DP-1";
              position = "2560,0";
              mode = "2560x1440@143.86Hz";
              status = "enable";
            }
            {
              criteria = "HDMI-A-1";
              position = "-1920,0";
              mode = "1920x1080@60.00Hz";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "work";
          outputs = [
            {
              criteria = "DP-4";
              position = "-1920,0";
              mode = "1920x1080@60Hz";
              status = "enable";
            }
            {
              criteria = "DP-3";
              position = "0,0";
              mode = "1920x1080@60Hz";
              status = "enable";
            }
            {
              criteria = "eDP-1";
              position = "1920,0";
              mode = "1920x1080@60Hz";
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
