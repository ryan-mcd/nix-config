{

  description = "Ryan-McD's flake!";

  inputs = {
    #################### Official NixOS and HM Package Sources ####################

    # nixpkgs = {
    #   url = "github:NixOS/nixpkgs/nixos-23.11";
    # };
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # also see 'unstable-packages' overlay at 'overlays/default.nix"

    hardware.url = "github:nixos/nixos-hardware";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    #################### Utilities ####################

    # sops-nix - secrets
    # https://github.com/Mic92/sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self
    , nixpkgs
    , home-manager
    , sops-nix
    , ... } @inputs:
    let
      supportedSystems = ["x86_64-linux" "aarch64-darwin" "aarch64-linux"];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      overlays = import ./overlays {inherit inputs;};
      mkSystemLib = import ./lib/mkSystem.nix {inherit inputs;};
      flake-packages = self.packages;

      legacyPackages = forAllSystems (
        system:
          import nixpkgs {
            inherit system;
            overlays = builtins.attrValues overlays;
            config.allowUnfree = true;
          }
      );
      lib = nixpkgs.lib;
    in  {
    nixosConfigurations = {
      homey = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/homey/configuration.nix ];
      };
    };
  };
}
