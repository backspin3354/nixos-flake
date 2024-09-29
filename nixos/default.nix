{ pkgs, lib, ... }:

{
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --remember-session \
          --greeting Welcome to NixOS!
      '';
    };
  };
  
  programs.sway = {
    enable = true;
    extraPackages = [];
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Do garbage collection weekly
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/New_York";

  i18n = let
    locale = "en_US.UTF-8";
  in {
    defaultLocale = locale;

    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    helix
    wget
    curl
    git
    fastfetch
    nix-tree
  ];

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      # Icon fonts
      material-design-icons

      # Normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # Nerdfonts
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # User defined fonts
    # The reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
