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
        term = "footclient";
      in {
        "${mod}+Return" = "exec ${term}";
        "${mod}+Shift+Return" = "exec firefox";

        "${mod}+Tab" = "exec $(tofi-drun --drun-launch=false --terminal=${term})";
        "${mod}+Shift+Tab" = "exec ${term} $(tofi-run)";
        
        "${mod}+c" = "kill";
        
        "${mod}+r" = "reload";
        "${mod}+q" = "exec swaymsg exit";
      };
    };
  };
}
