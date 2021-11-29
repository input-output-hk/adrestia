{ lib, config, ... }: let
  dns = import ../dns.nix { inherit lib; };
in {
  _module.args = {
    common = rec {
      domain = dns.zone;
      inherit (dns) hosts;

      backupJob = "gce-mob-dev";

      creds = import ../creds.nix;
    };
  };
}
