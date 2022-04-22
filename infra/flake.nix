{
  description = "Adrestia development infrastructure";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable-small;
    home-manager.url = github:nix-community/home-manager/release-21.11;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = github:numtide/flake-utils;
    customConfig.url = github:input-output-hk/empty-flake;

    # Import some useful stuff from rvl's config repo
    basic = {
      url = git+https://git.lorrimar.id.au/rodney/config.git?dir=basic;
      inputs.emacs.follows = "emacs";
      inputs.mylib.follows = "mylib";
      inputs.rodnix.follows = "rodnix";
    };
    emacs = {
      url = git+https://git.lorrimar.id.au/rodney/config.git?dir=emacs;
      inputs.mylib.follows = "mylib";
    };
    iohk-binary-cache.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=iohk-binary-cache;
    mylib.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=mylib;
    rodnix = {
      url = git+https://git.lorrimar.id.au/rodney/config.git?dir=rodnix;
      inputs.mylib.follows = "mylib";
    };
    scripts = {
      url = git+https://git.lorrimar.id.au/rodney/config.git?dir=scripts;
      inputs.scripting.follows = "scripting";
    };
    scripting.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=scripting;
    nixops-utils.url = git+https://git.lorrimar.id.au/rodney/config.git?dir=nixops-utils;
  };

  outputs = { self, flake-utils, mylib, ... }: let
    inherit (nixpkgs) lib;
    nixpkgs = mylib.lib.extendNixpkgs self.libOverlay self.overlay self.inputs.nixpkgs;
    nixpkgs-unstable = mylib.lib.extendNixpkgs self.libOverlay self.overlay self.inputs.nixpkgs-unstable;

    customConfig = lib.recursiveUpdate {
      repo = toString self.sourceInfo;
    } inputs.customConfig;

    # Inject dependencies using module arguments.
    specialArgs = {
      inherit customConfig;
      flakeInputs = self.inputs // {
        inherit (self) nixpkgs nixpkgs-unstable;
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
      emacs = self.inputs.emacs.overlay;
      mylib = self.inputs.mylib.overlay;
      rodnix = self.inputs.rodnix.overlay;
      scripting = self.inputs.scripting.overlay;
      scripts = self.inputs.scripts.overlay;
      cherry-pick-unstable = final: prev: {
        pkgsUnstable = self.inputs.nixpkgs-unstable.legacyPackages.${final.system};
        pkgsRelease = self.inputs.nixpkgs.legacyPackages.${final.system};
      };
      cherry-pick-element-latest = final: prev: {
        inherit (final.pkgsUnstable) element-web;
      };
    };
    libOverlay = mylib.lib.composeExtensionAttrs self.libOverlays;
    libOverlays = {
      release-compat = final: prev: {
        # required for self.nixosModules.release-compat which imports nix-daemon service from unstable.
        mkRenamedOptionModuleWith = { from, to, ... }: final.mkRenamedOptionModule from to;
      };
      mylib = mylib.libOverlay;
      custom-config = final: prev: { inherit customConfig; };
    };

    nixosModules.common = {
      imports = [
        self.nixosModules.release-compat
        self.nixosModules.keys
        self.inputs.rodnix.nixosModule
        self.inputs.rodnix.nixopsModule
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
        self.inputs.basic.roles.hm
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
        self.inputs.nixops-utils.nixosModules.dummy-nixops
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
      gceProps = {
        region = "australia-southeast1";
        tags = [
          "iohk"
          "adrestia"
        ];
      };
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
        deployment.gce = creds.gce // {
          # instance properties
          region = "${gceProps.region}-a";
          inherit (gceProps) tags;
          # network = resources.gceNetworks.adp-net;
        };
        imports = [
          self.nixosModules.gce-serial-console
        ];
        nixpkgs.overlays = [(self: super: (super.prefer-remote-fetch self super))];
      };

      gce-adp-web = { resources, ... }: {
        deployment.gce = {
          machineName = "n-048aa26e7caa11e58b4cda214536e17f-gce-mob-dev";

          # instance properties
          instanceType = "e2-small";

          # This should be plenty for the rootfs.
          # /nix/store is mounted with a separate disk.
          rootDiskSize = 30;

          # VPC Firewall rules are controlled by tags.
          tags = [
            # This allows HTTP(s) traffic to reach the instance.
            "web-server"
            # Allow jitsi videobridge traffic
            # "jitsi-videobridge"
            # Open ports for emacs crdt.el
            "emacs-crdt"
          ];

          scheduling.automaticRestart = true;
          scheduling.onHostMaintenance = "MIGRATE";
        };

        imports = [
          # gcloud compute --project=iohk-323702 connect-to-serial-port n-048aa26e7caa11e58b4cda214536e17f-gce-mob-dev --zone=australia-southeast1-a
          self.inputs.nixops-utils.serial-console
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

      resources.gceNetworks.adp-net = creds.gce // {
        name = "default";
        firewall = {
          web-server = {
            targetTags = [ "web-server" ];
            allowed.tcp = [ 80 443 ];
          };

          # Allow incoming connections for jitsi-meet calls.
          jitsi-videobridge = {
            targetTags = [ "jitsi-videobridge" ];
            allowed.tcp = [ 4443 ];
            allowed.udp = [ 10000 ];
            # gcloud compute --project=iohk-323702 firewall-rules create jitsi-videobridge --description="Allow incoming connections for jitsi-meet calls" --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:4443,udp:10000 --source-ranges=0.0.0.0/0 --target-tags=iohk,adrestia
          };
          # Allow incoming connections for crdt.el sessions.
          emacs-crdt = {
            # gcloud compute --project=iohk-323702 firewall-rules create emacs-crdt --description="Allow incoming connections for crdt.el sessions." --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:6530-6539 --source-ranges=0.0.0.0/0 --target-tags=iohk,adrestia
            targetTags = [ "emacs-crdt" ];
            allowed.tcp = [ "6530-6539" ];
          };
        };
      };
      resources.gceStaticIPs = {
        adp-web-ip = { resources, lib, ... }: creds.gce // {
          inherit (resources.machines.gce-mob-dev.deployment.gce) labels;
          inherit (gceProps) region;

          # name = "${namespace.machineName}-ip";
          name = "adp-web";
          ipAddress = "34.151.90.232";
          publicIPv4 = resources.gceStaticIPs.adp-web-ip.ipAddress;
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
          # like this?
          recordValues = [ resources.gceStaticIPs.adp-web-ip.publicIPv4 ];
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
    nixops = pkgs.nixopsUnstable;

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

            export NIX_PATH=nixpkgs=${toString nixpkgs}

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
