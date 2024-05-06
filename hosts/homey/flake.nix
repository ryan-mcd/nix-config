{

  description = "flake!";

  inputs = {
    # nixpkgs = {
    #   url = "github:NixOS/nixpkgs/nixos-23.11";
    # };
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }:
    let 
      lib = nixpkgs.lib;
    in  {
    nixosConfigurations = {
      homey = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
