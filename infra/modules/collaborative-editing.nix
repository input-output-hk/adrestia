{ config, lib, pkgs, common, ... }: let
  hedgedoc = config.services.hedgedoc;
  cfg = hedgedoc.configuration;

  inherit (common)
    domain
    hosts
    backupJob;

  database = "hedgedoc";
  user = "hedgedoc";

in {
  services.nginx.virtualHosts.${hosts.md} = {
    enableACME = true;
    forceSSL = true;

    locations."/" = {
      proxyPass = "http://${cfg.host}:${toString cfg.port}";
      proxyWebsockets = true;
    };

    locations."/socket.io/" = {
      proxyPass = "http://${cfg.host}:${toString cfg.port}";
      proxyWebsockets = true;
    };
  };

  services.hedgedoc = {
    enable = true;
    workDir = "/var/lib/hedgedoc";
    environmentFile = config.deployment.keys.iohk_hedgedoc.path;
    # groups = [ "www" ];
    configuration = {
      ################################################################
      # Database - see https://sequelize.readthedocs.io/en/v3/
      # dbURL = "postgres://hedgedoc:\${DB_PASSWORD}@localhost:5432/hedgedoc";
      # dbURL = "postgres://${user}@/${database}";
      dbURL = "sqlite://${hedgedoc.workDir}/db.hedgedoc.sqlite";
      uploadsPath = "${hedgedoc.workDir}/uploads";
      imageUploadType = "filesystem";

      ################################################################
      # Files (defaults)
      # Non-canonical paths are relative to HedgeDoc's base directory

      # # Path to the default Note file.
      # defaultNotePath = "./public/default.md";
      # # Path to the docs directory.
      # docsPath = "./public/docs";

      # # Template directory
      # viewPath = "./public/views";

      # # (obsolete) Path to the pretty template file.
      # prettyPath = "./public/views/pretty.ejs";
      # # (obsolete) Path to the slide template file.
      # slidePath = "./public/views/slide.hbs";
      # # (obsolete) Path to the index template file.
      # indexPath = "./public/views/index.ejs";
      # # (obsolete) Path to the hackmd template file.
      # hackmdPath = "./public/views/hackmd.ejs";

      ################################################################
      # Hosting

      # path = "/run/hedgedoc.sock"; # optional unix domain socket
      allowOrigin = [ "localhost" hosts.md ];
      domain = hosts.md;
      urlPath = null;
      protocolUseSSL = true;
      # TODO: enable HSTS once certificates are sorted
      hsts.enable = false;
      # content security policy. see https://helmetjs.github.io/docs/csp/
      # csp = {
      #                  enable = true;
      #                  directives = {
      #                    scriptSrc = "trustworthy.scripts.example.com";
      #                  };
      #                  upgradeInsecureRequest = "auto";
      #                  addDefaults = true;
      #                };

      ################################################################
      # Auth
      google = {
        clientID = "$CMD_GOOGLE_CLIENTID";
        clientSecret = "$CMD_GOOGLE_CLIENTSECRET";
      };

      sessionSecret = "$CMD_SESSION_SECRET";
      allowEmailRegister = false;
      email = false;

      ################################################################
      # Access control
      defaultPermission = "limited"; # one of "freely", "editable", "limited", "locked", "private"
      allowAnonymous = false;
      allowAnonymousEdits = true;

      allowFreeURL = true; # allow new note creation by accessing a nonexistent note URL

      allowGravatar = true;
      allowPDFExport = true;

      ################################################################
      # Other
      debug = false;
    };
  };
  systemd.services.hedgedoc.serviceConfig.Environment = [
    "CMD_REQUIRE_FREEURL_AUTHENTICATION=true" # requireFreeURLAuthentication = true
    "CMD_GOOGLE_HOSTEDDOMAIN=iohk.io" # google.hostedDomain = "iohk.io"
  ];

  deployment.keys.iohk_hedgedoc.destDir = "/var/lib/keys";

  services.borgbackup.jobs.${backupJob}.paths = [ hedgedoc.workDir ];

  services.postgresql = {
    ensureDatabases = [ database ];
    ensureUsers = [ {
      name = user;
      ensurePermissions = {
        "DATABASE \"${database}\"" = "ALL PRIVILEGES";
      };
    } ];
  };

  services.prometheus.scrapeConfigs = [{
    job_name = "hedgedoc";
    static_configs = [{
      targets = [ "${domain}:${toString cfg.port}" ];
    }];
  }];

}
