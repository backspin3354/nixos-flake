{ pkgs, ... }:

{
  imports =
    [
      ../../programs/firefox
    ];
  
  xdg.enable = true;

  home.packages = with pkgs; [
    github-desktop
  ];
    
  programs.btop.enable = true;
       
  programs.git = {
    userName = "Luke Willis";
    userEmail = "backspin3354@proton.me";
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "monospace:size=10";
      };
    };
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
    config = {
      keybindings = let
        mod = "Mod4";
      in {
        "${mod}+Return" = "exec footclient";
        "${mod}+Shift+Return" = "exec firefox";
        "${mod}+c" = "kill";
        
        "${mod}+r" = "reload";
        "${mod}+q" = "exec swaymsg exit";
      };
    };
  };
}
