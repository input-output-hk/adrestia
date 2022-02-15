{
  description = "Adrestia development infrastructure";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable-small;
    home-manager.url = github:nix-community/home-manager/release-21.11;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = github:numtide/flake-utils;

    customConfig.url = github:input-output-hk/empty-flake;

    basic.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=basic;
    basic.inputs.emacs.follows = "emacs";
    basic.inputs.mylib.follows = "mylib";
    basic.inputs.rodnix.follows = "rodnix";
    emacs.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=emacs;
    emacs.inputs.mylib.follows = "mylib";
    iohk-binary-cache.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=iohk-binary-cache;
    mylib.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=mylib;
    rodnix.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=rodnix;
    rodnix.inputs.mylib.follows = "mylib";
    scripts.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=scripts;
    scripts.inputs.mylib.follows = "mylib";
    nixops-utils.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=nixops-utils;
  };

  outputs = { self, flake-utils, mylib, ... }@inputs: let
    inherit (nixpkgs) lib;
    nixpkgs = mylib.lib.extendNixpkgs self.libOverlay self.overlay inputs.nixpkgs;
    nixpkgs-unstable = mylib.lib.extendNixpkgs self.libOverlay self.overlay inputs.nixpkgs-unstable;

    customConfig = lib.recursiveUpdate {
      repo = toString self.sourceInfo;
    } inputs.customConfig;

    # Inject dependencies using module arguments.
    specialArgs = {
      inherit customConfig;
      flakeInputs = inputs // {
        inherit self nixpkgs nixpkgs-unstable;
      };
      dns = import ./dns.nix { inherit lib; };
      creds = import ./creds.nix;
    };

  in {
    inherit nixpkgs;

    overlay = mylib.lib.composeExtensionAttrs1
      self.overlays
      (mylib.lib.applyLibOverlay self.libOverlay);
    overlays = {
      emacs = inputs.emacs.overlay;
      mylib = mylib.overlay;
      rodnix = inputs.rodnix.overlay;
      scripts = inputs.scripts.overlay;
      cherry-pick-unstable = final: prev: {
        pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages.${final.system};
        pkgsRelease = inputs.nixpkgs.legacyPackages.${final.system};
      };
      cherry-pick-element-latest = final: prev: {
        inherit (final.pkgsUnstable) element-web;
      };
    };
    libOverlay = mylib.lib.composeExtensionAttrs self.libOverlays;
    libOverlays = {
      base = final: prev: { };
      mylib = mylib.libOverlay;
      custom-config = final: prev: { inherit customConfig; };
    };

    nixosModules.common = {
      imports = [
        self.nixosModules.release-compat
        self.nixosModules.keys
        inputs.rodnix.nixosModule
        inputs.rodnix.nixopsModule
        ./modules/basics.nix
        ./modules/backup.nix
      ];
      nixpkgs.overlays = [ self.overlay ];
      system.stateVersion = "21.11";
      time.timeZone = "UTC";
    };

    # This module sets up a root filesystem for local testing builds of nixos systems.
    nixosModules.pretend-rootfs = {
      fileSystems."/" = {
        fsType = "ext4";
        device = "/dev/disk/by-label/nixos";
        autoResize = true;
      };
      boot.loader.grub.device = lib.mkDefault "/dev/vda";
    };

    nixosModules.gce-mob-dev = { dns, ...}: {
      imports = [
        self.nixosModules.common
        inputs.basic.roles.hm
        # TODO: move some services over to gce-collab
        ./roles/mob-prog.nix
        ./roles/iohk-mob-dev-server.nix
      ];

      networking = { inherit (dns) hostName domain; };

      # Preserve ssh host keys
      # ssh-keygen -t ed25519 -C "mob-dev_ssh_host_key" -f mob-dev_ssh_host_ed25519_key -P ""
      deployment.keys = {
        mob-dev-ssh_host_rsa_key = { destDir = "/etc/ssh"; name = "ssh_host_rsa_key"; };
        mob-dev-ssh_host_ed25519_key = { destDir = "/etc/ssh"; name = "ssh_host_ed25519_key"; };
      };
    };

    nixosModules.gce-collab = { dns, ...}: {
      imports = [
        self.nixosModules.common
        ./roles/iohk-mob-dev-server.nix
      ];

      networking = { inherit (dns) hostName domain; };

      # Preserve ssh host keys
      # ssh-keygen -t ed25519 -C "mob-dev_ssh_host_key" -f mob-dev_ssh_host_ed25519_key -P ""
      deployment.keys = {
        collab-ssh_host_rsa_key = { destDir = "/etc/ssh"; name = "ssh_host_rsa_key"; };
        collab-ssh_host_ed25519_key = { destDir = "/etc/ssh"; name = "ssh_host_ed25519_key"; };
      };
    };

    nixosModules.keys = { lib, creds, ... }:  {
      deployment.keys = lib.genAttrs creds.keys (name: {
        keyCommand = [ "${toString ./scripts}/fetch.sh" name ];
        destDir = lib.mkDefault "/var/lib/keys";
      });
    };

    nixosModules.release-compat = {
      disabledModules = [ "services/misc/nix-daemon.nix" ];
      imports = [ "${specialArgs.flakeInputs.nixpkgs-unstable}/nixos/modules/services/misc/nix-daemon.nix" ];
    };

    nixosModules.gce-serial-console = {
      # gcloud compute --project=iohk-323702 connect-to-serial-port n-048aa26e7caa11e58b4cda214536e17f-gce-mob-dev --zone=australia-southeast1-a
      deployment.gce.metadata.serial-port-enable = "TRUE";
      imports = [ inputs.nixops-utils.nixosModules.serial-console ];
    };

    nixosConfigurations = lib.mapAttrs (name: module: lib.nixosSystem {
      inherit lib;
      specialArgs = specialArgs // { inherit name; };
      system = "x86_64-linux";
      modules = [
        inputs.nixops-utils.nixosModules.dummy-nixops
        self.nixosModules.pretend-rootfs
        self.nixosModules.${name}
        module
      ];
    }) {
      gce-mob-dev = {};
      gce-collab = {};
    };

    nixopsConfigurations.default = { gceAccessKeyFile ? null }: let
      specialArgs' = lib.recursiveUpdate specialArgs {
        creds.gce.accessKey = if gceAccessKeyFile != null
          then lib.fileContents gceAccessKeyFile
          else lib.trace "Warning: `gceAccessKeyFile` nixops deployment parameter was not set." "";
      };
      hackNixopsLib = final: prev: {
        nixosSystem = final.nodelib.specialNixosSystem prev.nixosSystem specialArgs';
      };
      inherit (specialArgs') dns creds;
    in {
      nixpkgs = mylib.lib.extendNixpkgs
        (nixpkgs.lib.composeExtensions self.libOverlay hackNixopsLib)
        self.overlay
        self.nixpkgs;

      network = {
        description = "Adrestia development infrastructure";
        enableRollback = true;
        storage.legacy = {};
      };

      defaults = {
        deployment.targetEnv = "gce";
        deployment.gce = {
          # credentials
          inherit (creds.gce) project serviceAccount accessKey;

          # instance properties
          region = "australia-southeast1-a";

          # VPC Firewall rules are controlled by tags.
          # gcloud compute --project=iohk-323702 firewall-rules create jitsi-videobridge --description="Allow incoming connections for jitsi-meet calls" --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:4443,udp:10000 --source-ranges=0.0.0.0/0 --target-tags=iohk,adrestia
          # gcloud compute --project=iohk-323702 firewall-rules create emacs-crdt --description="Allow incoming connections for crdt.el sessions." --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:6530-6539 --source-ranges=0.0.0.0/0 --target-tags=iohk,adrestia
          tags = [
            "iohk"
            "adrestia"
          ];
        };
        imports = [
          self.nixosModules.gce-serial-console
        ];
        nixpkgs.overlays = [(self: super: (super.prefer-remote-fetch self super))];
      };

      gce-mob-dev = { resources, ... }: {
        deployment.gce = {
          # instance properties
          instanceType = "e2-standard-4";

          # This should be plenty for the rootfs.
          # /nix/store is mounted with a separate disk.
          rootDiskSize = 30;

          # VPC Firewall rules are controlled by tags.
          # This allows HTTP(s) traffic to reach the instance.
          tags = [
            "http-server"
            "https-server"
          ];
          scheduling.automaticRestart = true;
          scheduling.onHostMaintenance = "MIGRATE";
        };

        imports = [
          self.nixosModules.gce-mob-dev
        ];

        adp.backup.s3.enable = true;
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
      };

      resources.route53HostedZones.${dns.zone} = {
        name = "${dns.zone}.";
        comment = "Adrestia dev hosted zone";
        inherit (creds.aws) accessKeyId;
      };

      resources.route53RecordSets = let
        mkRecord = recordType: domainName: { resources, nodes, ... }: {
          zoneId = resources.route53HostedZones.${dns.zone};
          ttl = 60;
          # fixme: how to get config.networking.publicIPv4 from nixops-gcp?
          # recordValues = [ resources.machines.gce-mob-dev.publicIpv4 ];
          recordValues = [ dns.ipv4.gce-mob-dev ];
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
    };
  } // flake-utils.lib.eachDefaultSystem (system: let
    inherit (self.nixpkgs) lib;
    pkgs = self.nixpkgs.legacyPackages.${system};

    shellScripts = {
      update-nixops = pkgs.writeShellApplication {
        name = "update-nixops";
        runtimeInputs = [ nixops pkgs.awscli shellScripts.fetch-secret ];
        text = builtins.readFile ./scripts/update-nixops.sh;
      };
      fetch-secret = pkgs.writeShellApplication {
        name = "fetch-secret";
        runtimeInputs = [ pkgs.bitwarden-cli ];
        text = builtins.readFile ./scripts/fetch.sh;
      };
      update-flake-lock = pkgs.writeShellApplication {
        name = "update-flake-lock";
        runtimeInputs = [ nix ];
        text = builtins.readFile ./scripts/update-flake-lock.sh;
      };
    };

    nix = pkgs.pkgsUnstable.nixUnstable;
    nixops = pkgs.pkgsUnstable.nixopsUnstable;

    flake = {
      packages = shellScripts // lib.mapAttrs
        (name: nixos: nixos.config.system.build.toplevel)
        self.nixosConfigurations;

      devShell = flake.devShells.default;
      devShells = {
        default = pkgs.mkShell rec {
          name = "adp-infra";
          buildInputs = [
            nix
            nixops
          ] ++ (with pkgs; [
            awscli
            google-cloud-sdk
            bitwarden-cli
            coreutils
          ] ++ lib.attrValues shellScripts);

          NIXOPS_DEPLOYMENT = "adp-infra";
          AWS_PROFILE = "adrestia";

          BW_ORGANIZATION_ID = "3bbffbd9-f0f8-4fb7-9d18-cca627081df0";
          BW_COLLECTION_ID = "de029761-b704-40c7-a106-105cde4b5a35";
          BW_FOLDER_ID = "59643128-fa70-4e8b-adac-496d6782cb66";

          shellHook = ''
            export top=$(${pkgs.gitMinimal}/bin/git rev-parse --show-toplevel)/infra

            # Use a nixops state file local to this repo.
            export NIXOPS_STATE="$top/.state/${NIXOPS_DEPLOYMENT}.nixops";
            export BITWARDENCLI_APPDATA_DIR="$top/.state";

            echo "NixOps: ${nixops.version}"
            echo "State file: $(realpath --relative-to="$top" $NIXOPS_STATE)"
            echo
          '';
        };
      };
    };
  in
    flake);

  nixConfig.bash-prompt = "\\u@\\h:\\w \[$name\] \\$ ";
}
