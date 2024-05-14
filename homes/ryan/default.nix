{
  pkgs,
  lib,
  inputs,
  hostname,
  flake-packages,
  ...
}:
{
  imports = [
    ../_modules

    # ./secrets
    ./hosts/${hostname}.nix
  ];

  modules = {

    security = {
      ssh = {
        enable = true;
        };
      };
    };

    shell = {
      # fish.enable = true;

      git = {
        enable = true;
        username = "Ryan-McD";
        email = "72583999+ryan-mcd@users.noreply.github.com";
      };

      go-task.enable = true;
    };
  };
}