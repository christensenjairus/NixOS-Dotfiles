{
  description = "Jairus' System-Producing Flake";

  inputs = {
    # Waking from suspend-then-hibernate doesn't seem to work on the unstable channels
    #nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "nixpkgs/nixos-22.11";
    #home-manager.url = "github:nix-community/home-manager/master"; # unstable
    home-manager.url = "github:nix-community/home-manager/release-22.11"; # unstable
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in {
      homeManagerConfigurations = {
        line6 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # username = "line6";
          # homeDirectory = "/home/line6";
          modules = [
            #imports = [
              ./NIXOS/home/line6.nix
            #];
          ];
        };
      };

      nixosConfigurations = {
        Ares-NixOS = lib.nixosSystem {

          inherit system;

          modules = [
            # ./NIXOS/configuration.nix
            ./NIXOS/systems/thinkpadt480s.nix
            ./NIXOS/my_configuration.nix
            ./NIXOS/power-management.nix
            ./NIXOS/programs.nix
            ./NIXOS/awesomewm.nix
          ];
        };
      };
    };
}
