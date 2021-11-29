{ config, lib, pkgs, ... }: let
  alertmanager = config.services.prometheus.alertmanager;
  cfg = alertmanager.matrix;

  listen = service: "${if service.listenAddress == "" then "127.0.0.1" else service.listenAddress}:${toString service.port}";
  httpListen = service: "http://${listen service}";

in {
  options = with lib; {
    services.prometheus.alertmanager.matrix = {
      enable = mkEnableOption "Matrix chat room client for Prometheus Alert Manager.";
      receivers = mkOption {
        description = ''Configure Alertmanager receivers'';
        type = types.listOf (types.submodule {
          options = {
            name = mkOption {
              description = "Receiver name";
              type = types.str;
            };
            roomId = {
              description = "Chat room to send alerts to.";
              type = types.str;
            };
            extraConfig = {
              description = "Extra webhook_config configuration";
              type = types.attrs;
              default = {};
              example = { send_resolved = true; max_alerts = 10; };
            };
          };
        });
        default = [];
        example = [ { name = "matrix"; roomId = "#alerts:matrix.org"; } ];
      };
      package = mkOption {
        type = types.package;
        description = "The package that provides alertmanager_matrix.";
        default = pkgs.alertmanager-matrix;
      };
      listenAddress = mkOption {
        description = ''
          Address to listen on. Empty string will listen on all interfaces.
           "localhost" will listen on 127.0.0.1 (but not ::1).
        '';
        type = types.str;
        default = "";
      };
      port = mkOption {
        description = "Port to listen on.";
        type = types.port;
        default = 4051;
      };
      alertmanager = mkOption {
        description = "URL of alertmanager to connect to.";
        type = types.str;
        default = httpListen alertmanager;
      };
      homeserver = mkOption {
        description = "URL of Matrix homeserver to send messages to.";
        type = types.str;
        default = "http://127.0.0.1:8008";
      };
      colorFile = mkOption {
        description = "JSON file with colors for message types.";
        type = types.nullOr types.path;
        default = null;
      };
      iconFile = mkOption {
        description = "JSON file with icons for message types.";
        type = types.nullOr types.path;
        default = null;
      };
      messageType = mkOption {
        description = "Type of message the bot uses. (Defaults to m.notice)";
        type = types.nullOr types.str;
        default = null;
      };
      rooms = mkOption {
        description = ''
          List of rooms from which commands are allowed.
          All rooms are allowed by default.
        '';
        type = types.listOf types.str;
        default = [];
      };
      token = mkOption {
        description = ''
          Token to connect with. If null, the $TOKEN environment variable is used.
        '';
        type = types.nullOr types.str;
        default = null;
      };
      userId = mkOption {
        description = "User ID to connect with.";
        type = types.str;
      };      
      options = mkOption {
        description = "Options to pass to the command line.";
        type = types.separatedString " ";
        default = lib.concatStringsSep " " (lib.concatLists [
          [ "-addr" (listen cfg) ]
          [ "-alertmanager" cfg.alertmanager ]
          [ "-homeserver" cfg.homeserver ]
          [ "-userID" cfg.userId ]
          (lib.optional (cfg.token != null) "-token ${cfg.token}")
          (lib.optional (cfg.messageType != null) "-message-type ${cfg.messageType}")
          (lib.optional (cfg.colorFile != null) "-color-file ${cfg.colorFile}")
          (lib.optional (cfg.iconFile != null) "-icon-file ${cfg.iconFile}")
          (lib.optional (cfg.rooms != []) "-rooms ${lib.concatStringsSep "," cfg.rooms}")
        ]);
      };
      environmentFile = mkOption {
        type = types.nullOr types.path;
        example = "/run/keys/alertmanager_matrix_token";
        default = null;
        description = ''
          Environment file as defined in <citerefentry>
          <refentrytitle>systemd.exec</refentrytitle><manvolnum>5</manvolnum>
          </citerefentry>.
        '';
      };
   };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [(self: super: {
      alertmanager-matrix = self.callPackage ../../pkg/alertmanager-matrix.nix {};
    })];

    # fixme: doesn't seem to merge properly
    services.prometheus.alertmanager.configuration.receivers = map (receiver: {
      inherit (receiver) name;
      webhook_configs = [(receiver.extraConfig // {
        url = "${httpListen cfg}/${receiver.roomId}";
      })];
    }) cfg.receivers;

    systemd.services.alertmanager-matrix = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      description = "Alerts from Alertmanager to Matrix";

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/alertmanager_matrix ${cfg.options}";
        EnvironmentFile = lib.mkIf (cfg.environmentFile != null) cfg.environmentFile;
        Restart = "always";
        DynamicUser = "yes";
      };
    };
  };
}
