{ config, options, resources, lib, pkgs, ... }: let
  cfg = config.adp.backup;
  enableBackup = cfg.job != null;

in {
  options = with lib; {
    adp.backup.job = mkOption {
      description = ''Name of the borgbackup job'';
      type = types.str;
      default = config.networking.hostName;
    };
    # adp.backup.job2 = lib.mkAliasDefinitions options.services.borgbackup.jobs.${config.adp.backup.job};
    adp.backup.repo = mkOption {
      description = ''Location to save borgbackup data'';
      type = types.str;
      default = "${cfg.s3.mountPoint}/borg";
    };
    adp.backup.s3.enable = mkEnableOption ''Mount s3fs for backups'';
    adp.backup.s3.mountPoint = mkOption {
      description = ''Location to mount backup media'';
      type = types.str;
      default = "/mnt/backup";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (enableBackup && config.adp.backup.s3.enable) (let
      storageUnit = config.services.s3fs.mounts.backup.unit;
    in {
      services.s3fs = {
        enable = true;
        mounts.backup = {
          inherit (cfg.s3) mountPoint;
          passwordFile = config.deployment.keys.iohk_s3backup.path;
          umask = "0027";
          options = {
            nofail = true;
          };
        };
      };

      rodnix.key-deps.iohk_s3backup = [ storageUnit ];
      systemd.services."borgbackup-job-${cfg.job}" = {
        after = [ storageUnit ];
        requires = [ storageUnit ];
      };
    }))
    (lib.mkIf enableBackup {
      rodnix.key-deps.borgbackup-gce-mob-dev = [ "borgbackup-job-${cfg.job}" ];

      services.borgbackup.jobs.${cfg.job} = {
        inherit (cfg) repo;
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
        # databases = lib.mkForce []; # backup all databases
        # new options in nixos-21.11:
        backupAll = true;
        compression = "zstd";
      };
    })
  ];
}
