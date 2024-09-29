{ config, pkgs, ... }:

{
  imports = 
    [
      ../../nixos
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # WiFi adapter
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ rtl88x2bu ];
    blacklistedKernelModules = [ "rtw88_8822bu" ];
  };

  # Networking
  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
