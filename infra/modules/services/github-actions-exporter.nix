{ config, lib, pkgs, ... }: let
  cfg = config.services.prometheus.github-actions-exporter;
in {
  options = with lib; {
    services.prometheus.github-actions-exporter = {
      enable = mkEnableOption "Prometheus GitHub Actions exporter.";
      package = mkOption {
        type = types.package;
        description = "The package that provides alertmanager_matrix.";
        default = pkgs.github-actions-exporter;
      };
      port = mkOption {
        description = "Port to listen on.";
        type = types.port;
        default = 9999;
      };
      auth = mkOption {
        description = ''
          API authentication - either personal access token or GitHub app.
          If null, $GITHUB_TOKEN is used.
        '';
        default = null;
        type = types.either (types.nullOr types.str) (types.submodule {
          options = {
            appId = mkOption {
              description = "GitHub app.";
              type = types.int;
            };
            appInstallationId = mkOption {
              description = "Installation of GitHub app.";
              type = types.int;
            };
            privateKey = mkOption {
              description = "GitHub app private key. If null, $GITHUB_APP_PRIVATE_KEY is used";
              type = types.nullOr types.str;
              default = null;
            };
          };
        });
      };
      refresh = mkOption {
        description = "GitHub Refresh.";
        type = types.int;
        default = 30;
      };
      orgs = mkOption {
        description = "List all organizations you want get informations.";
        type = types.listOf types.str;
        default = [];
      };
      repos = mkOption {
        description = ''
          List all repositories you want get informations.
          Each entry is in the form of owner/repo.
        '';
        type = types.listOf types.str;
        default = [];
      };
      options = mkOption {
        description = "Options to pass to the command line.";
        type = types.separatedString " ";
        default = lib.concatStringsSep " " ([
          "-port ${toString cfg.port}"
          "-github_refresh ${toString cfg.refresh}"
          ] ++ lib.optional (cfg.auth != null)
            (if (builtins.typeOf cfg.auth == "string")
              then [ "-github_token ${cfg.auth}" ]
              else [
                "-app_id ${toString cfg.auth.appId}"
                "-app_installation_id ${toString cfg.auth.appInstallationId}"
              ] ++ lib.optional (cfg.auth.privateKey != null)
                "-app_private_key ${toString cfg.auth.privateKey}")
            ++ lib.optional (cfg.orgs != [])
              "-github_orgas ${lib.concatStringsSep "," cfg.orgs}"
            ++ lib.optional (cfg.repos != [])
              "-github_repos ${lib.concatStringsSep "," cfg.repos}");
      };
      environmentFile = mkOption {
        type = types.nullOr types.path;
        example = "/run/keys/github-actions-exporter";
        default = null;
        description = ''
          Environment file as defined in <citerefentry>
          <refentrytitle>systemd.exec</refentrytitle><manvolnum>5</manvolnum>
          </citerefentry>.
        '';
      };
   };
  };

  config = {
    nixpkgs.overlays = [(self: super: {
      github-actions-exporter = self.callPackage ../../pkg/github-actions-exporter.nix {};
    })];

    systemd.services.github-actions-exporter = lib.mkIf cfg.enable {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      description = "Prometheus exporter for GitHub Actions";
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/github-actions-exporter ${cfg.options}";
        EnvironmentFile = lib.mkIf (cfg.environmentFile != null) cfg.environmentFile;
        Restart = "always";
        DynamicUser = "yes";
      };
    };
  };
}
