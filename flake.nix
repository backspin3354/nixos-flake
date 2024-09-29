{
  description = "My NixOS configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = let
      # Function for quickly adding a user's modules to a configuration
      user = username: [
        # Create nixos user
        {
          users.users.${username} = {
            isNormalUser = true;
            description = username;
            extraGroups = ["networkmanager" "wheel"];
          };
        }

        # Setup home-manager for user
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = inputs;
            users.${username} = {
              imports = [ ./home/users/${username} ];
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "24.05";
              };
              programs.home-manager.enable = true;
              systemd.user.startServices = "sd-switch";
            };
          };
        }
      ];
    in {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop
        ] ++ (user "lukejw");
      };
    };
  };
}
