{ config, lib, pkgs, common, ... }: let
  inherit (common)
    domain
    hosts
    backupJob;

  keys = [
    "iohk_oauth2_client_secret"
    "iohk_grafana_admin_password"
    "iohk_grafana_secret_key"
  ];

  grafana = config.services.grafana;
  prometheus = config.services.prometheus;

  grafanaURL = "https://${hosts.monitoring}/grafana/";

  alertsRoom = "#infra-alerts:${domain}";
  alertsRoomId = "!JkJgzWQQidiYpNuYYG:${domain}";

in {
  services.prometheus = {
    enable = true;
    extraFlags = [
      "--storage.tsdb.retention=${toString (150 * 24)}h"
      "--web.external-url=https://${hosts.monitoring}/prometheus/"
    ];

    exporters = {
      node = {
        enable = true;
        enabledCollectors = [
          "logind"
          "systemd"
        ];
      };
      nginx = {
        enable = true;
      };
      postgres = {
        enable = true;
        runAsLocalSuperUser = true;
      };
      jitsi = {
        enable = true;
        # url = "http://localhost:8080/colibri/stats";
      };
    };

    globalConfig.scrape_interval = "15s";
    scrapeConfigs = let
      localExporter = job_name: exporter: cfg: lib.recursiveUpdate {
        inherit job_name;
        static_configs = [{
          targets = [ "${domain}:${toString exporter.port}" ];
        }];
      } cfg;
    in [
      (localExporter "node" prometheus.exporters.node {})
      (localExporter "nginx" prometheus.exporters.nginx {})
      (localExporter "postgresql" prometheus.exporters.postgres {
        metrics_path = "/metrics";
      })
      (localExporter "github-actions" prometheus.github-actions-exporter {})
      (localExporter "jitsi" prometheus.exporters.jitsi {})
    ];

    alertmanagers = [{
      scheme = "http";
      static_configs = [{
        targets = ["${domain}:${toString prometheus.alertmanager.port}"];
      }];
    }];

    alertmanager = {
      enable = true;
      configuration = {
        global = {};
        route = {
          receiver = "ignore";
          group_wait = "30s";
          group_interval = "5m";
          repeat_interval = "4h";
          group_by = [ "alertname" ];

          routes = [{
            receiver = "matrix";
            group_wait = "30s";
            match.severity = "page";
          }];
        };
        receivers = [ {
          # with no *_config, this will drop all alerts directed to it
          name = "ignore";
        }  {
          name = "matrix";
          webhook_configs = [{
            url = "http://127.0.0.1:${toString prometheus.alertmanager.matrix.port}/${alertsRoomId}";
            send_resolved = true;
          }];
        }];
      };
    };

    rules = [(builtins.toJSON {
      groups = [{
        name = "system";
        rules = [
          {
            alert = "RootPartitionLowInodes";
            expr = ''node_filesystem_files_free{mountpoint="/"} <= 10000'';
            for = "30m";
            labels.severity = "page";
            annotations.summary = "${grafanaURL}d/node/node-exporter?orgId=1&refresh=30s&var-instance={{ $labels.instance }}";
          }
          {
            alert = "RootPartitionLowDiskSpace";
            expr = ''node_filesystem_avail_bytes{mountpoint="/"} <= 1000000000''; # 1GB
            for = "30m";
            labels.severity = "page";
            annotations.summary = "${grafanaURL}d/node/node-exporter?orgId=1&refresh=30s&var-instance={{ $labels.instance }}";
          }
          {
            alert = "SystemStateDegraded";
            expr = ''node_systemd_system_running == 0'';
            for = "5s";
            # for = "15m";
            labels.severity = "page";
            annotations.summary = "${grafanaURL}d/systemd/systemd-service-dashboard?orgId=1&refresh=30s&var-instance={{ $labels.instance }}";
          }
          {
            alert = "TestAlert";
            expr = ''node_systemd_unit_state{name="prometheus-jitsi-exporter.service", state="inactive"} == 1'';
            labels.severity = "page";
            annotations.summary = "${grafanaURL}d/systemd/systemd-service-dashboard?orgId=1&refresh=30s&var-instance={{ $labels.instance }}";
          }
        ];
      } {
        name = "backups";
        rules = [{
          alert = "BorgbackupFailed";
          expr = ''node_systemd_unit_state{name=~"^borgbackup-job-.*.service$", state="failed"} == 1'';
          for = "8h";
          labels.severity = "page";
          annotations.summary = "${grafanaURL}";
        }];
      }];
    })];
  };

  imports = [
    ./services/alertmanager-matrix.nix
    ./services/github-actions-exporter.nix
  ];

  services.prometheus.alertmanager.matrix = {
    enable = true;
    homeserver = "http://[::1]:8008";
    userId = "@alertmanager:${domain}";
    environmentFile = config.deployment.keys.iohk_alertmanager_matrix_token.path;
    rooms = [ alertsRoom alertsRoomId ];
    receivers = [{
      name = "matrix";
      roomId = alertsRoomId;
      extraConfig.send_resolved = true;
    }];
    colorFile = ./monitoring/alertmanager-matrix-colors.json;
    iconFile = ./monitoring/alertmanager-matrix-icons.json;
  };
  systemd.services.alertmanager-matrix = let
    services = [ "matrix-synapse.service" ];
  in {
    after = services;
    requires = services;
  };

  services.prometheus.github-actions-exporter = {
    enable = true;
    # orgs = ["input-output-hk"];
    repos = ["input-output-hk/cardano-wallet"];
    environmentFile = config.deployment.keys.iohk_github_actions_exporter_token.path;
  };
  rodnix.key-deps.iohk_github_actions_exporter_token = [ "github-actions-exporter" ];
  # deployment.keys.iohk_github_actions_exporter_token.destDir = "/var/lib/keys";

  services.nginx = {
    statusPage = true;
    virtualHosts.${hosts.monitoring} = {
      enableACME = true;
      forceSSL = true;

      locations = {
        "/".return = "302 https://${hosts.monitoring}/grafana/";
        "/prometheus/" = {
          proxyPass = "http://${prometheus.listenAddress}:${toString prometheus.port}";
          proxyWebsockets = true;
          extraConfig = ''
            auth_request /oauth2/auth;
            error_page 401 = /oauth2/sign_in?rd=https%3A%2F%2F$host$request_uri;
          '';
        };
        "/grafana/" = {
          proxyPass = "http://${grafana.addr}:${toString grafana.port}/";
          proxyWebsockets = true;
        };
      };
    };
  };

  services.grafana = {
    enable = true;
    port = 3333;
    auth.google = {
      enable = true;
      allowSignUp = false;
      inherit (common.creds.oauth2) clientId;
      clientSecretFile = config.deployment.keys.iohk_oauth2_client_secret.path;
    };
    security = {
      adminUser = "rodney.lorrimar@iohk.io";
      adminPasswordFile = config.deployment.keys.iohk_grafana_admin_password.path;
      secretKeyFile = config.deployment.keys.iohk_grafana_secret_key.path;
    };
    database = {
      type = "postgres";
      name = "grafana";
      user = "grafana";
      host = "127.0.0.1:${toString config.services.postgresql.port}";
      # sudo -u postgres psql -c "ALTER USER grafana PASSWORD '...';"
      passwordFile = config.deployment.keys.iohk_grafana_admin_password.path;
    };
    domain = hosts.monitoring;
    rootUrl = "https://${hosts.monitoring}/grafana/";
    extraOptions.serve_from_sub_path = "true";
    declarativePlugins = with pkgs.grafanaPlugins; [
      grafana-piechart-panel
      grafana-worldmap-panel
      grafana-clock-panel
      (pkgs.callPackage ../pkg/grafana-github-datasource.nix {})
    ];
    provision = {
      enable = true;
      datasources = [{
        name = "Prometheus";
        url = "http://${prometheus.listenAddress}:${toString prometheus.port}/prometheus/";
        isDefault = true;
        type = "prometheus";
      # } {
      #   name = "GitHub";
      #   type = "github";
      # } {
      #   name = "Google Cloud Monitoring";
      #   url = "";
      #   type = "google-cloud-monitoring";
      }];
      dashboards = [{
        folder = "Infra";
        name = "node";
        options.path = ./dashboards/node_exporter.json;
        type = "file";
      } {
        folder = "Infra";
        name = "systemd";
        options.path = ./dashboards/systemd.json;
        type = "file";
      } {
        folder = "Dev";
        name = "github";
        options.path = ./dashboards/github-grafana.json;
        type = "file";
      } {
        folder = "Dev";
        name = "github-org";
        options.path = ./dashboards/github-grafana-org.json;
        type = "file";
      }];
      notifiers = [{
        is_default = true;
        type = "prometheus-alertmanager";
        uid = "alertmanager";
        settings.url = "http://${domain}:${toString prometheus.alertmanager.port}";
      }];
    };
  };

  users.users.grafana = {
    isSystemUser = true;
    group = "grafana";
    extraGroups = [ "keys" ];
  };

  deployment.keys = lib.genAttrs keys (name: {
    destDir = "/var/lib/keys";
    user = "grafana";
  }) // {
    iohk_alertmanager_matrix_token.destDir = "/var/lib/keys";
  };

  systemd.services.grafana = let
    services = map (key: "${key}-key.service") keys;
  in {
    after = services;
    wants = services;
  };

  services.borgbackup.jobs.${backupJob}.paths = [ config.services.grafana.dataDir ];

  services.postgresql = with config.services.grafana.database; {
    ensureDatabases = [ name ];
    ensureUsers = [{
      name = user;
      ensurePermissions = {
        "DATABASE \"${name}\"" = "ALL PRIVILEGES";
      };
    }];
    authentication = ''
      host ${name} ${user} 127.0.0.1/32 trust
    '';
  };
}
