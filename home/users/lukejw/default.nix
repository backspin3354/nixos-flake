{ pkgs, lib, ... }:

{
  imports =
    [
      ../../themes/gruvbox
      ../../programs/firefox
    ];
  
  xdg.enable = true;

  home.packages = with pkgs; [
    github-desktop
    swaybg
  ];
    
  programs.btop.enable = true;
         
  programs.git = {
    userName = "Luke Willis";
    userEmail = "backspin3354@proton.me";
  };

  programs.tofi.enable = true;

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "monospace:size=10";
      };
    };
  };

  services.wlsunset = {
    enable = true;
    sunrise = "07:30";
    temperature.day = 6500;
    sunset = "19:30";
    temperature.night = 2000;
  };

  programs.helix = {
    enable = true;
    settings.editor = {
      line-number = "relative";
      lsp.display-messages = true;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = let
      term = "footclient";
    in {
      defaultWorkspace = "1";
      modifier = "Mod4";
      terminal = "${term}";
      menu = "$(tofi-drun --drun-launch=false --terminal=${term})";
            
      startup = let
        wallpaper = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/AngelJumbo/gruvbox-wallpapers/refs/heads/main/wallpapers/irl/forest.jpg";
          hash = "sha256-mqrwRvJmRLK3iyEiXmaw5UQPftEaqg33NhwzpZvyXws=";
        };
      in [
        { command = "swaybg -i ${wallpaper} -o \"*\""; }
      ];
    };
  };
}
