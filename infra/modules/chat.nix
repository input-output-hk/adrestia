{ config, lib, pkgs, common, ... }: let

  inherit (common)
    domain
    hosts
    backupJob;

  synapseConfigKeys = [
    "iohk_oauth2_matrix"
    "iohk_matrix_registration_shared_secret"
  ];

in {
  services.postgresql = {
    ensureDatabases = [ config.services.matrix-synapse.database_name ];
    ensureUsers = [ {
      name = config.services.matrix-synapse.database_user;
      ensurePermissions = {
        "DATABASE \"${config.services.matrix-synapse.database_name}\"" = "ALL PRIVILEGES";
      };
    } ];
  };

  services.nginx.virtualHosts = {
      # This host section can be placed on a different host than the rest,
      # i.e. to delegate from the host being accessible as ${config.networking.domain}
      # to another host actually running the Matrix homeserver.
      ${domain} = {
        locations."= /.well-known/matrix/server".extraConfig =
          let
            # use 443 instead of the default 8448 port to unite
            # the client-server and server-server port for simplicity
            server = { "m.server" = "${hosts.matrix}:443"; };
          in ''
            add_header Content-Type application/json;
            return 200 '${builtins.toJSON server}';
          '';
        locations."= /.well-known/matrix/client".extraConfig =
          let
            client = {
              "m.homeserver" =  { "base_url" = "https://${hosts.matrix}"; };
              "m.identity_server" =  { "base_url" = "https://vector.im"; };
              "im.vector.riot.jitsi" = { "preferredDomain" = "${hosts.jitsi}"; };
            };
          # ACAO required to allow element-web on any URL to request this json file
          in ''
            add_header Content-Type application/json;
            add_header Access-Control-Allow-Origin *;
            return 200 '${builtins.toJSON client}';
          '';
      };

      # Reverse proxy for Matrix client-server and server-server communication
      ${hosts.matrix} = {
        enableACME = true;
        forceSSL = true;

        # Matrix docs say do not put a Matrix Web client here!
        # So redirect to the URL for element web client.
        locations."/".extraConfig = ''
          return 302 https://${hosts.element};
        '';

        # forward all Matrix API calls to the synapse Matrix homeserver
        locations."~* ^(\/_matrix|\/_synapse\/client)" = {
          proxyPass = "http://[::1]:8008"; # without a trailing /
          extraConfig = ''
            # Nginx by default only allows file uploads up to 1M in size

            # Increase client_max_body_size to match max_upload_size
            # defined in homeserver.yaml
            client_max_body_size ${config.services.matrix-synapse.max_upload_size};
          '';
        };
      };

      ${hosts.element} = {
        enableACME = true;
        forceSSL = true;

        root = pkgs.element-web.override {
          # https://github.com/vector-im/element-web/blob/develop/docs/config.md
          conf = {
            default_server_config."m.homeserver" = {
              "base_url" = "https://${hosts.matrix}";
              "server_name" = "Adrestia Chat";
            };
            # https://github.com/vector-im/element-web/blob/develop/docs/labs.md
            showLabsSettings = true;
            features = {
              feature_spaces = true;
              # feature_communities_v2_prototypes = true;
              # feature_thread = true;  # seems a little broken
              feature_pinning = true;
              feature_custom_status = true;
              feature_dnd = true;
              # feature_presence_in_room_list = true;
              # feature_maximised_widgets = true;
              feature_latex_maths = true;
            };
            disable_custom_urls = true;
            permalinkPrefix = "https://${hosts.element}";
            jitsi.preferredDomain = hosts.jitsi;
            # jitsi.preferredDomain = "jitsi.riot.im";
          };
        };
      };
  };

  services.matrix-synapse = {
    enable = true;
    server_name = domain;
    # enable_registration = true;
    # registration_shared_secret = "";
    listeners = [{
      port = 8008;
      bind_address = "::1";
      type = "http";
      tls = false;
      x_forwarded = true;
      resources = [{
        names = [ "client" "federation" ];
        compress = false;
      }];
    }];
    public_baseurl = "https://${hosts.matrix}/";
    extraConfigFiles = map (name: config.deployment.keys.${name}.path) synapseConfigKeys;
  };

  systemd.services.matrix-synapse = let
    services = map (key: "${key}-key.service") synapseConfigKeys;
  in {
    after = services;
    wants = services;
  };
  deployment.keys = lib.genAttrs synapseConfigKeys (key: {
    destDir = "/var/lib/keys";
    group = "matrix-synapse";
    permissions = "0640";
  });
  users.users.matrix-synapse.extraGroups = [ "keys" ];

  users.users.root.packages = [
    pkgs.matrix-synapse
    pkgs.jq
  ];

  services.borgbackup.jobs.${backupJob}.paths = [
    config.services.matrix-synapse.dataDir
  ];
}
