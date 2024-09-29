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
    config = let
      term = "footclient";
    in {
      modifier = "Mod4";
      terminal = "${term}";
      menu = "$(tofi-drun --drun-launch=false --terminal=${term})";
      startup = [
        { command = "${term} fastfetch"; }
      ];
    };
  };
}
