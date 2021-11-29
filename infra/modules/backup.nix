{ config, resources, lib, pkgs, common, utils, ... }: let
  inherit (common)
    backupJob;

  repo = "${mountPoint}/borg";
  mountPoint = "/mnt/backup";
  storageUnit = config.services.s3fs.mounts.backup.unit;

in {
  services.s3fs = {
    enable = true;
    mounts.backup = {
      inherit mountPoint;
      passwordFile = config.deployment.keys.iohk_s3backup.path;
      umask = "0027";
      options = {
        nofail = true;
      };
    };
  };

  rodnix.key-deps.iohk_s3backup = [ storageUnit ];
  systemd.services."borgbackup-job-${backupJob}" = {
    after = [ storageUnit ];
    requires = [ storageUnit ];
  };
  rodnix.key-deps.borgbackup-gce-mob-dev = [ "borgbackup-job-${backupJob}" ];

  services.borgbackup.jobs.${backupJob} = {
    inherit repo;
    doInit = true;
    removableDevice = true;
    paths = [
      "/home"
      "/srv"
      "/root"
      "/var/log"
      config.services.postgresqlBackup.location
    ];
    exclude = [
      "sh:/home/*/.cache/"
      "sh:/home/*/Downloads/"

      # Haskell builds
      "sh:**/.stack/"
      "sh:**/.stack-work/"
      "sh:**/dist-newstyle/"
      # nodejs builds
      "sh:**/node_modules/"
      # rust builds
      "sh:/home/*/.cargo/"
      # Python builds
      "*.pyc"
    ];
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.deployment.keys.borgbackup-gce-mob-dev.path}";
    };
    compression = "auto,zstd";
    extraCreateArgs = "--exclude-caches --stats";
    startAt = "hourly";
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 6;
    };
    # extraPruneArgs = "--list --show-rc";
  };

  services.postgresqlBackup = {
    enable = true;
    databases = lib.mkForce []; # backup all databases
    # new options in nixos-unstable:
    # backupAll = true;
    # compression = "zstd";
  };
}
