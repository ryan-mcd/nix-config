# Sourced from https://github.com/bjw-s/nix-config/blob/7b2e67026015730183d068e1ddcc814e41d1b6d5/hosts/milton/secrets.nix
{
  pkgs,
  config,
  ...
}:
{
  config = {
    environment.systemPackages = [
      pkgs.sops
      pkgs.age
    ];

    sops = {
      defaultSopsFile = ./secrets.sops.yaml;
      age.sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];

    };
  };
}