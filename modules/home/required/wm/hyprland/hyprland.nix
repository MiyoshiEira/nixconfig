{ inputs, config, lib, pkgs, ... }:
let
  pkgs-hyprland =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ../../shell/wezterm.nix
    (import ../../style/networkmanager-dmenu.nix {
      dmenu_command = "fuzzel -d";
      inherit config lib pkgs;
    })
    ../input/nihongo.nix
    inputs.ags.homeManagerModules.default
  ];

  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = if (config.stylix.polarity == "light") then
      "Quintom_Ink"
    else
      "Quintom_Snow";
    size = 36;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
      inputs.hycov.packages.${pkgs.system}.hycov
    ];
    settings = { };
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
      exec-once = hyprctl setcursor '' + config.gtk.cursorTheme.name + " "
      + builtins.toString config.gtk.cursorTheme.size + ''



        env = GBM_BACKEND,nvidia-drm
        env = LIBVA_DRIVER_NAME,nvidia
        env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        env = XDG_CURRENT_DESKTOP,Hyprland
        env = XDG_SESSION_TYPE,wayland
        env = XDG_SESSION_DESKTOP,Hyprland
        env = WLR_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1
        env = GDK_BACKEND,wayland,x11,*
        env = QT_QPA_PLATFORM,wayland;xcb
        env = QT_QPA_PLATFORMTHEME_NAME,qt5ct
        env = QT_AUTO_SCREEN_SCALE_FACTOR,1
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
        env = CLUTTER_BACKEND,wayland

        exec-once = pypr
        exec-once = ydotoold
        exec-once = nm-applet
        exec-once = blueman-applet
        exec-once = GOMAXPROCS=1 syncthing --no-browser
        exec-once = webcord
        exec-once = nextcloud
        exec-once = kanshi
        exec-once = ags &> /dev/null & disown
        exec-once = emacs --daemon
        exec-once = swww --daemon
        exec-once = swww img -o HDMI-A-1 ~/.dotfiles/configs/assets/wallpaper.gif
        exec-once = swww img -o DP-1 ~/.dotfiles/configs/assets/wallpaper.gif
        exec-once = swww img -o DP-2 ~/.dotfiles/configs/assets/wallpaper.gif
        exec-once = swww img -o DP-3 ~/.dotfiles/configs/assets/wallpaper.gif
        exec-once = swww img -o DP-4 ~/.dotfiles/configs/assets/wallpaper.gif
        exec-once = swww img -o eDP-1 ~/.dotfiles/configs/assets/wallpaper.gif



        exec-once = hypridle
        exec-once = sleep 5 && libinput-gestures
        exec-once = obs-notification-mute-daemon

        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.0
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        bezier = linear, 0.0, 0.0, 1.0, 1.0

        animations {
             enabled = yes
             animation = windowsIn, 1, 6, winIn, popin
             animation = windowsOut, 1, 5, winOut, popin
             animation = windowsMove, 1, 5, wind, slide
             animation = border, 1, 10, default
             animation = borderangle, 1, 100, linear, loop
             animation = fade, 1, 10, default
             animation = workspaces, 1, 5, wind
             animation = windows, 1, 6, wind, slide
        }

        general {
          layout = dwindle
          border_size = 1
          col.active_border = 0xff'' + config.lib.stylix.colors.base08 + " "
      + "0xff" + config.lib.stylix.colors.base09 + " " + "0xff"
      + config.lib.stylix.colors.base0A + " " + "0xff"
      + config.lib.stylix.colors.base0B + " " + "0xff"
      + config.lib.stylix.colors.base0C + " " + "0xff"
      + config.lib.stylix.colors.base0D + " " + "0xff"
      + config.lib.stylix.colors.base0E + " " + "0xff"
      + config.lib.stylix.colors.base0F + " " + ''
        270deg

                col.inactive_border = 0xaa'' + config.lib.stylix.colors.base02
      + ''

             resize_on_border = true
             gaps_in = 1
             gaps_out = 1
        }

        plugin {
          hyprtrails {
              color = rgba('' + config.lib.stylix.colors.base08 + ''
          55)
                   }
                   hycov {
                       overview_gappo = 60 # gaps width from screen edge
                       overview_gappi = 24 # gaps width from clients
                       enable_hotarea = 0 # enable mouse cursor hotarea, when cursor enter hotarea, it will toggle overview
                       enable_click_action = 1 # enable mouse left button jump and right button kill in overview mode
                       hotarea_monitor = all # monitor name which hotarea is in, default is all
                       hotarea_pos = 1 # position of hotarea (1: bottom left, 2: bottom right, 3: top left, 4: top right)
                       hotarea_size = 10 # hotarea size, 10x10
                       swipe_fingers = 3 # finger number of gesture,move any directory
                       move_focus_distance = 100 # distance for movefocus,only can use 3 finger to move
                       enable_gesture = 0 # enable gesture
                       auto_exit = 1 # enable auto exit when no client in overview
                       auto_fullscreen = 0 # auto make active window maximize after exit overview
                       only_active_workspace = 0 # only overview the active workspace
                       only_active_monitor = 0 # only overview the active monitor
                       enable_alt_release_exit = 0 # alt swith mode arg,see readme for detail
                       alt_replace_key = Super_L # alt swith mode arg,see readme for detail
                       alt_toggle_auto_next = 0 # auto focus next window when toggle overview in alt swith mode
                       click_in_cursor = 1 # when click to jump,the target windwo is find by cursor, not the current foucus window.
                       hight_of_titlebar = 0 # height deviation of title bar height
                       show_special = 0 # show windwos in special workspace in overview.

                   }
                 }

                 bind=SUPER,SPACE,fullscreen,1
                 bind=SUPERSHIFT,F,fullscreen,0
                 bind=ALT,TAB,cyclenext
                 bind=ALT,TAB,bringactivetotop
                 bind=SUPER,TAB,hycov:toggleoverview
                 bind=SUPER,left,movewindow,l
                 bind=SUPER,down,movewindow,d
                 bind=SUPER,up,movewindow,u
                 bind=SUPER,right,movewindow,r


                 bind=SUPER,RETURN,exec,wezterm

                 bind=SUPER,code:47,exec,fuzzel
                 bind=SUPER,Q,killactive
                 bind=SUPERSHIFT,Q,exit
                 bindm=SUPER,mouse:272,movewindow
                 bindm=SUPER,mouse:273,resizewindow
                 bind=SUPER,T,togglefloating

                 bind=SHIFTCTRL,4,exec,"/home/miyoshieira/Documents/scripts/waylandscreenshot.sh"
                 bind=SHIFTCTRL,5,exec,"/home/miyoshieira/Documents/scripts/waylandscreenshot2.sh"



                 bind=SUPERCTRL,L,exec,loginctl lock-session

                 #pyprland stuff

                 bind=SUPERSHIFT,N,togglespecialworkspace, stash
                 bind=SUPER,N,exec,pypr toggle_special stash
                 bind=SUPER,S,exec,pypr toggle easyeffects && hyprctl dispatch bringactivetotop
                 bind=SUPER,A,exec,pypr toggle keepassxc && hyprctl dispatch bringactivetotop
                 bind=SUPER,z,exec,pypr toggle term && hyprctl dispatch bringactivetotop

                 $scratchpadsize = size 80% 85%

                 $scratchpad = class:^(scratchpad)$
                 windowrulev2 = float,$scratchpad
                 windowrulev2 = $scratchpadsize,$scratchpad
                 windowrulev2 = workspace special silent,$scratchpad
                 windowrulev2 = center,$scratchpad

                 windowrulev2 = float,class:^(Element)$
                 windowrulev2 = size 85% 90%,class:^(Element)$
                 windowrulev2 = center,class:^(Element)$

                 $savetodisk = title:^(Save to Disk)$
                 windowrulev2 = float,$savetodisk
                 windowrulev2 = size 70% 75%,$savetodisk
                 windowrulev2 = center,$savetodisk

                 $pavucontrol = class:^(pavucontrol)$
                 windowrulev2 = float,$pavucontrol
                 windowrulev2 = size 86% 40%,$pavucontrol
                 windowrulev2 = move 50% 6%,$pavucontrol
                 windowrulev2 = workspace special silent,$pavucontrol
                 windowrulev2 = opacity 0.80,$pavucontrol

                 $miniframe = title:\*Minibuf.*
                 windowrulev2 = float,$miniframe
                 windowrulev2 = size 64% 50%,$miniframe
                 windowrulev2 = move 18% 25%,$miniframe
                 windowrulev2 = animation popin 1 20,$miniframe


                 windowrulev2 = opacity 0.80,title:ORUI

                 windowrulev2 = opacity 1.0,class:^(Brave-browser),fullscreen:1
                 windowrulev2 = opacity 0.9,class:^(org.keepassxc.KeePassXC)$
                 windowrulev2 = opacity 0.75,class:^(org.gnome.Nautilus)$
                 windowrulev2 = opacity 0.75,class:^(org.gnome.Nautilus)$

                 layerrule = blur,waybar
                 layerrule = xray,waybar
                 blurls = waybar
                 layerrule = blur,launcher # fuzzel
                 blurls = launcher # fuzzel
                 layerrule = blur,gtk-layer-shell
                 layerrule = xray,gtk-layer-shell
                 blurls = gtk-layer-shell
                 layerrule = blur,~nwggrid
                 layerrule = xray 1,~nwggrid
                 layerrule = animation fade,~nwggrid
                 blurls = ~nwggrid


                 xwayland {
                   force_zero_scaling = true
                 }

                 binds {
                   movefocus_cycles_fullscreen = false
                 }

                 input {
                   kb_layout = se
                   kb_options = caps:escape
                   repeat_delay = 350
                   repeat_rate = 50
                   accel_profile = flat
                   follow_mouse = 2
                 }

                 misc {
                   disable_hyprland_logo = true
                   mouse_move_enables_dpms = false
                 }
                 decoration {
                   rounding = 8
                   blur {
                     enabled = true
                     size = 5
                     passes = 2
                     ignore_opacity = true
                     contrast = 1.17
                     brightness = 0.8
                     xray = true
                   }
                 }

        '';
    xwayland = { enable = true; };
    systemd.enable = true;
  };

  home.packages = (with pkgs; [
    bun
    dart-sass
    fd
    feh
    dmenu
    killall
    polkit_gnome
    papirus-icon-theme
    libva-utils
    libinput-gestures
    gsettings-desktop-schemas
    (pyprland.overrideAttrs (_oldAttrs: {
      src = fetchFromGitHub {
        owner = "hyprland-community";
        repo = "pyprland";
        rev = "refs/tags/2.2.17";
        hash = "sha256-S1bIIazrBWyjF8tOcIk0AwwWq9gbpTKNsjr9iYA5lKk=";
      };
    }))
    gnome.zenity
    wlr-randr
    wtype
    ydotool
    wl-clipboard
    hyprland-protocols
    hyprpicker
    hypridle
    hyprpaper
    fnott
    fuzzel
    keepmenu
    pinentry-gnome3
    wev
    grim
    slurp
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    wlsunset
    pavucontrol
    pamixer
    tesseract4
    (pkgs.writeScriptBin "obs-notification-mute-daemon" ''
      #!/bin/sh
      while true; do
        if pgrep -x .obs-wrapped > /dev/null;
          then
            pkill -STOP fnott;
          else
            pkill -CONT fnott;
        fi
        sleep 10;
      done
    '')
  ]) ++ (with pkgs-hyprland; [ hyprlock ]);
  home.file.".local/share/pixmaps/hyprland-logo-stylix.svg".source =
    config.lib.stylix.colors {
      template = builtins.readFile
        ../../../../../configs/assets/hyprland-logo-stylix.svg.mustache;
      extension = "svg";
    };
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pgrep hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      ignore_dbus_inhibit = false
    }

    listener {
      timeout = 1500 # in seconds
      on-timeout = loginctl lock-session
    }
    listener {
      timeout = 600 # in seconds
      on-timeout = systemctl suspend
    }
  '';
  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = screenshot

      # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
      blur_passes = 4
      blur_size = 5
      noise = 0.0117
      contrast = 0.8916
      brightness = 0.8172
      vibrancy = 0.1696
      vibrancy_darkness = 0.0
    }

    input-field {
      monitor =
      size = 200, 50
      outline_thickness = 3
      dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = false
      dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
      outer_color = rgb('' + config.lib.stylix.colors.base07-rgb-r + ","
    + config.lib.stylix.colors.base07-rgb-g + ", "
    + config.lib.stylix.colors.base07-rgb-b + ''
      )
            inner_color = rgb('' + config.lib.stylix.colors.base00-rgb-r + ","
    + config.lib.stylix.colors.base00-rgb-g + ", "
    + config.lib.stylix.colors.base00-rgb-b + ''
      )
            font_color = rgb('' + config.lib.stylix.colors.base07-rgb-r + ","
    + config.lib.stylix.colors.base07-rgb-g + ", "
    + config.lib.stylix.colors.base07-rgb-b + ''
      )
            fade_on_empty = true
            fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
            placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
            hide_input = false
            rounding = -1 # -1 means complete rounding (circle/oval)
            check_color = rgb('' + config.lib.stylix.colors.base0A-rgb-r + ","
    + config.lib.stylix.colors.base0A-rgb-g + ", "
    + config.lib.stylix.colors.base0A-rgb-b + ''
      )
            fail_color = rgb('' + config.lib.stylix.colors.base08-rgb-r + ","
    + config.lib.stylix.colors.base08-rgb-g + ", "
    + config.lib.stylix.colors.base08-rgb-b + ''
      )
            fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
            fail_transition = 300 # transition time in ms between normal outer_color and fail_color
            capslock_color = -1
            numlock_color = -1
            bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
            invert_numlock = false # change color if numlock is off
            swap_font_color = false # see below

            position = 0, -20
            halign = center
            valign = center
          }

          label {
            monitor =
            text = 愛
            color = rgb('' + config.lib.stylix.colors.base07-rgb-r + ","
    + config.lib.stylix.colors.base07-rgb-g + ", "
    + config.lib.stylix.colors.base07-rgb-b + ''
      )
            font_size = 25
            font_family = Noto Fonts
            rotate = 0 # degrees, counter-clockwise

            position = 0, 160
            halign = center
            valign = center
          }

          label {
            monitor =
            text = $TIME
            color = rgb('' + config.lib.stylix.colors.base07-rgb-r + ","
    + config.lib.stylix.colors.base07-rgb-g + ", "
    + config.lib.stylix.colors.base07-rgb-b + ''
      )
            font_size = 20
            font_family = Noto Fonts
            rotate = 0 # degrees, counter-clockwise

            position = 0, 80
            halign = center
            valign = center
          }
    '';
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads", "magnify", "toggle_special"]

    [scratchpads.term]
    command = "wezterm"
    margin = 50

    [scratchpads.easyeffects]
    command = "easyeffects"
    margin = 50

    [scratchpads.keepassxc]
    command = "keepassxc o /home/miyoshieira/Nextcloud/Private.kdbx"
    margin = 50

    [scratchpads.pavucontrol]
    command = "pavucontrol"
    margin = 50
    unfocus = "hide"
    animation = "fromTop"

  '';

  programs.ags = {
    enable = true;
    configDir = ../../../../../configs/ags;
  };

  home.file.".config/libinput-gestures.conf".text = ''
    gesture swipe up 3	hyprctl dispatch hycov:toggleoverview
    gesture swipe down 3	nwggrid-wrapper

    gesture swipe right 3	hyprnome
    gesture swipe left 3	hyprnome --previous
    gesture swipe up 4	hyprctl dispatch movewindow u
    gesture swipe down 4	hyprctl dispatch movewindow d
    gesture swipe left 4	hyprctl dispatch movewindow l
    gesture swipe right 4	hyprctl dispatch movewindow r
    gesture pinch in	hyprctl dispatch fullscreen 1
    gesture pinch out	hyprctl dispatch fullscreen 1
  '';

  services.udiskie.enable = true;
  services.udiskie.tray = "always";
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      #font = userSettings.font + ":size=20";
      dpi-aware = "no";
      show-actions = "yes";
      terminal = "${pkgs.wezterm}/bin/wezterm";
    };
    colors = {
      background = config.lib.stylix.colors.base00 + "bf";
      text = config.lib.stylix.colors.base07 + "ff";
      match = config.lib.stylix.colors.base05 + "ff";
      selection = config.lib.stylix.colors.base08 + "ff";
      selection-text = config.lib.stylix.colors.base00 + "ff";
      selection-match = config.lib.stylix.colors.base05 + "ff";
      border = config.lib.stylix.colors.base08 + "ff";
    };
    border = {
      width = 3;
      radius = 7;
    };
  };
  services.fnott.enable = true;
  services.fnott.settings = {
    main = {
      anchor = "bottom-right";
      stacking-order = "top-down";
      min-width = 400;
      #title-font = userSettings.font + ":size=14";
      #summary-font = userSettings.font + ":size=12";
      #body-font = userSettings.font + ":size=11";
      border-size = 0;
    };
    low = {
      background = config.lib.stylix.colors.base00 + "e6";
      title-color = config.lib.stylix.colors.base03 + "ff";
      summary-color = config.lib.stylix.colors.base03 + "ff";
      body-color = config.lib.stylix.colors.base03 + "ff";
      idle-timeout = 150;
      max-timeout = 30;
      default-timeout = 8;
    };
    normal = {
      background = config.lib.stylix.colors.base00 + "e6";
      title-color = config.lib.stylix.colors.base07 + "ff";
      summary-color = config.lib.stylix.colors.base07 + "ff";
      body-color = config.lib.stylix.colors.base07 + "ff";
      idle-timeout = 150;
      max-timeout = 30;
      default-timeout = 8;
    };
    critical = {
      background = config.lib.stylix.colors.base00 + "e6";
      title-color = config.lib.stylix.colors.base08 + "ff";
      summary-color = config.lib.stylix.colors.base08 + "ff";
      body-color = config.lib.stylix.colors.base08 + "ff";
      idle-timeout = 0;
      max-timeout = 0;
      default-timeout = 0;
    };
  };
}
