{ config, lib, pkgs, common, ... }: let
  inherit (common)
    backupJob
    hosts;

  mkTurnUri = port: transport: "turn:${hosts.jitsi}:${toString port}?transport=${transport}";

  turnPorts = with config.services.coturn; [ listening-port tls-listening-port ];

in {
  networking.firewall = {
    allowedTCPPorts = turnPorts;
    allowedUDPPorts = turnPorts;
  };

  services.jitsi-meet = {
    enable = true;
    hostName = hosts.jitsi;
    # https://github.com/jitsi/jitsi-meet/blob/master/config.js
    config = {
      #enableWelcomePage = false;
      prejoinPageEnabled = true;
    };
    # https://github.com/jitsi/jitsi-meet/blob/master/interface_config.js
    interfaceConfig = {
      SHOW_JITSI_WATERMARK = false;
      SHOW_WATERMARK_FOR_GUESTS = false;
    };
    # nginx.enable = true;
  };
  services.jitsi-videobridge = {
    # enable = true;  # already enabled by jitsi-meet servicee
    openFirewall = true;
    # https://github.com/jitsi/jitsi-videobridge/blob/master/src/main/resources/reference.conf
    config = {};
  };
  services.prometheus.exporters.jitsi = {
    enable = true;
  };

  # fixme: check auth, reload when certs are refreshed
  services.coturn = let
    certs = config.security.acme.certs.${hosts.jitsi}.directory;
  in {
    enable = false;
    use-auth-secret = true;
    # new nixpkgs only
    # static-auth-secret-file = config.deployment.keys.iohk_turn_shared_secret.path;
    realm = hosts.jitsi;
    # no-tcp-relay = true;
    cert = "${certs}/fullchain.pem";
    pkey = "${certs}/key.pem";
  };

  # services.matrix-synapse = {
  #   extraConfigFiles = [
  #     config.deployment.keys.iohk_turn_shared_secret_matrix.path
  #   ];
  #   turn_uris = lib.concatMap (port: map (mkTurnUri port) [ "udp" "tcp" ]) turnPorts;
  # };

  services.borgbackup.jobs.${backupJob}.paths = [
    config.services.prosody.dataDir
    "/var/lib/jitsi-meet"
  ];
}
