{ nixpkgs
, home-manager
, rvlConfig
, gceAccessKeyFile ? null
, description ? ""
}: let

  inherit (nixpkgs) lib;

  creds = lib.recursiveUpdate (import ./creds.nix) {
    gce.accessKey = lib.fileContents gceAccessKeyFile;
  };

  dns = import ./dns.nix { inherit lib; };

in {
  inherit nixpkgs;

  network = {
    inherit description;
    enableRollback = true;
    storage.legacy = {};
  };

  gce-mob-dev = { resources, ... }: {
    deployment.targetEnv = "gce";
    deployment.gce = {
      # credentials
      inherit (creds.gce) project serviceAccount accessKey;

      # instance properties
      region = "australia-southeast1-a";
      instanceType = "e2-standard-4";

      # This should be plenty for the rootfs.
      # /nix/store is mounted with a separate disk.
      rootDiskSize = 30;

      # VPC Firewall rules are controlled by tags.
      # gcloud compute --project=iohk-323702 firewall-rules create jitsi-videobridge --description="Allow incoming connections for jitsi-meet calls" --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:4443,udp:10000 --source-ranges=0.0.0.0/0 --target-tags=iohk,adrestia
      # gcloud compute --project=iohk-323702 firewall-rules create emacs-crdt --description="Allow incoming connections for crdt.el sessions." --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:6530-6539 --source-ranges=0.0.0.0/0 --target-tags=iohk,adrestia
      tags = [
        "iohk"
        "adrestia"
        "http-server"
        "https-server"
      ];
      scheduling.automaticRestart = true;
      scheduling.onHostMaintenance = "MIGRATE";

      # canIpForward = true;
      metadata = {
        serial-port-enable = "TRUE";
      };
    };

    nixpkgs.pkgs = nixpkgs.legacyPackages.x86_64-linux;
    nixpkgs.overlays = [(self: super: (super.prefer-remote-fetch self super))];

    imports = [
      home-manager.nixosModule
      (import "${rvlConfig}/rodnix/module.nix" { isNixOps = true; })
      ./roles/mob-prog.nix
      ./roles/iohk-mob-dev-server.nix

      # gcloud compute --project=iohk-323702 connect-to-serial-port n-048aa26e7caa11e58b4cda214536e17f-gce-mob-dev --zone=australia-southeast1-a
      "${rvlConfig}/modules/hardware/serial-console.nix"
      "${rvlConfig}/roles/base.nix"
      "${rvlConfig}/roles/term.nix"
      "${rvlConfig}/roles/basic-dev.nix"
      "${rvlConfig}/modules/common/iohk-binary-cache.nix"
    ];

    networking = {
      inherit (dns) hostName domain;
    };

    time.timeZone = "UTC";

    services.s3fs.mounts.backup = with resources.s3Buckets.backup; {
      bucket = name;
      options.endpoint = region;
    };

    fileSystems.nix-store = {
      autoFormat = true;
      autoResize = true;
      gce.disk_name = "store";
      gce.size = 50;
      gce.diskType = "ssd";  # fixme: "balanced" might be better, if nixops_gcp supports it
      gce.encrypt = false;
    };

    deployment.keys = lib.genAttrs creds.keys (name: {
      keyCommand = [ "${toString ./scripts}/fetch.sh" name ];
      destDir = lib.mkDefault "/var/lib/keys";
    });
  };

  resources.route53HostedZones.${dns.zone} =
    { name = "${dns.zone}.";
      comment = "Adrestia dev hosted zone";
      inherit (creds.aws) accessKeyId;
    };

  resources.route53RecordSets = let
    mkRecord = recordType: domainName: { resources, nodes, ... }: {
      zoneId = resources.route53HostedZones.${dns.zone};
      ttl = 60;
      # fixme: how to get config.networking.publicIPv4 from nixops-gcp?
      # recordValues = [ resources.machines.gce-mob-dev.publicIpv4 ];
      recordValues = [ "34.151.124.220" ];
      inherit recordType domainName;
      inherit (creds.aws) accessKeyId;
    };
  in lib.listToAttrs (lib.concatMap
    (name: map (type: lib.nameValuePair "${type}-${name}" (mkRecord type "${name}.")) ["A"])
    (lib.attrValues dns.hosts));

  resources.s3Buckets.backup = rec {
    name = "adrestia-iohk-dev-io-backup";
    inherit (creds.aws) accessKeyId;
    region = "ap-southeast-2";
    persistOnDestroy = true;
    policy = ''
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Sid": "allow-backup",
            "Effect": "Allow",
            "Principal": {
              "AWS": [
                "arn:aws:iam::763788805280:user/backup"
              ]
            },
            "Action": [
              "s3:GetObject",
              "s3:GetBucketLocation",
              "s3:ListBucket",
              "s3:PutObject",
              "s3:PutObjectAcl",
              "s3:DeleteObject"
            ],
            "Resource": [
              "arn:aws:s3:::${name}",
              "arn:aws:s3:::${name}/*"
            ]
          }
        ]
      }
    '';
  };
}
