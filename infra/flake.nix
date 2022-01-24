{
  description = "Adrestia development infrastructure";

  inputs = {
    # rvl.url = path:/home/rodney/ops/config;
    rvl.url = git+https://git.lorrimar.id.au/rodney/config.git;
    rvl.inputs.nixpkgs.follows = "nixpkgs";
    rvl.inputs.nixpkgs-release.follows = "nixpkgs";
    rvl.inputs.nixpkgs-ustable.follows = "nixpkgs-unstable";
    rvl.inputs.flake-utils.follows = "flake-utils";
    rvl.inputs.home-manager.follows = "home-manager";
    rvl.inputs.customConfig.follows = "customConfig";
    rvl.inputs.basic.follows = "basic";
    rvl.inputs.emacs.follows = "emacs";
    rvl.inputs.iohk-binary-cache.follows = "iohk-binary-cache";
    rvl.inputs.mylib.follows = "mylib";
    rvl.inputs.rodnix.follows = "rodnix";
    rvl.inputs.scripts.follows = "scripts";
    rvl.inputs.nixops-utils.follows = "nixops-utils";
    # rvl.inputs.xmonad.follows = "xmonad";

    # basic.url = path:/home/rodney/ops/config/basic;
    # emacs.url = path:/home/rodney/ops/config/emacs;
    # iohk-binary-cache.url = path:/home/rodney/ops/config/iohk-binary-cache;
    # mylib.url = path:/home/rodney/ops/config/mylib;
    # rodnix.url = path:/home/rodney/ops/config/rodnix;
    # scripts.url = path:/home/rodney/ops/config/scripts;
    # nixops-utils.url = path:/home/rodney/ops/config/nixops-utils;
    basic.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=basic;
    emacs.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=emacs;
    iohk-binary-cache.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=iohk-binary-cache;
    mylib.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=mylib;
    rodnix.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=rodnix;
    scripts.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=scripts;
    nixops-utils.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=nixops-utils;

    flake-utils.url = github:numtide/flake-utils;

    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;

    home-manager.url = github:nix-community/home-manager/release-21.11;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    customConfig.url = github:input-output-hk/empty-flake;
  };

  outputs = { self, flake-utils, rvl, mylib, ... }@inputs: let
    inherit (nixpkgs) lib;
    nixpkgs = mylib.lib.extendNixpkgs self.libOverlay self.overlay inputs.nixpkgs;
    nixpkgs-unstable = mylib.lib.extendNixpkgs self.libOverlay self.overlay inputs.nixpkgs-unstable;

    # Inject dependencies using module arguments.
    specialArgs = {
      flakeInputs = inputs // {
        inherit (self) nixpkgs nixpkgs-unstable;
        customConfig = lib.recursiveUpdate {
          repo = toString rvl.sourceInfo;
        } inputs.customConfig;
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
      rodnix = inputs.rodnix.libOverlay;
    };

    nixosModules.common = {
      imports = [
        inputs.rodnix.nixosModule
        inputs.rodnix.nixopsModule
        ./modules/basics.nix
        ./modules/backup.nix
      ];
      nixpkgs.overlays = [ self.overlay ];
      system.stateVersion = "21.11";
    };

    nixosModules.temp = {
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
        self.nixosModules.keys

        ./roles/mob-prog.nix
        ./roles/iohk-mob-dev-server.nix
      ];

      networking = { inherit (dns) hostName domain; };
      time.timeZone = "UTC";
      # Preserve ssh host keys
      # ssh-keygen -t ed25519 -C "mob-dev_ssh_host_key" -f mob-dev_ssh_host_ed25519_key -P ""
      deployment.keys = {
        mob-dev-ssh_host_rsa_key = { destDir = "/etc/ssh"; name = "ssh_host_rsa_key"; };
        mob-dev-ssh_host_ed25519_key = { destDir = "/etc/ssh"; name = "ssh_host_ed25519_key"; };
      };
    };

    nixosModules.keys = { lib, creds, ... }:  {
      deployment.keys = lib.genAttrs creds.keys (name: {
        keyCommand = [ "${toString ./scripts}/fetch.sh" name ];
        destDir = lib.mkDefault "/var/lib/keys";
      });
    };

    nixosConfigurations.gce-mob-dev = lib.nixosSystem {
      inherit lib;
      specialArgs = specialArgs // {
        name = "gce-mob-dev";
      };
      system = "x86_64-linux";
      modules = [
        inputs.nixops-utils.nixosModules.dummy-nixops
        self.nixosModules.gce-mob-dev
        self.nixosModules.temp
      ];
    };

    nixopsConfigurations.default = { gceAccessKeyFile ? null }: let
      specialArgs' = lib.recursiveUpdate specialArgs {
        creds.gce.accessKey = lib.fileContents gceAccessKeyFile;
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

        imports = [
        # # gcloud compute --project=iohk-323702 connect-to-serial-port n-048aa26e7caa11e58b4cda214536e17f-gce-mob-dev --zone=australia-southeast1-a
          "${rvl}/modules/hardware/serial-console.nix"
          self.nixosModules.gce-mob-dev
        ];

        nixpkgs.overlays = [(self: super: (super.prefer-remote-fetch self super))];

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

    nix = pkgs.pkgsUnstable.nix;
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