{ config, lib, pkgs, common, ... }: let
  inherit (common)
    domain
    hosts;
in {
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  security.acme = {
    email = "mb.acme@rodney.id.au";
    acceptTerms = true;
    certs.${domain} = {
      postRun = ''
        systemctl reload nginx.service
      '' + lib.optionalString config.services.coturn.enable ''
        systemctl reload coturn.service
      '';
      extraDomainNames = lib.attrValues hosts;
    };
  };

  services.nginx = {
    enable = true;
    # only recommendedProxySettings and recommendedGzipSettings are strictly required,
    # but the rest make sense as well
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts.${domain} = {
      enableACME = true;
      forceSSL = true;
      default = true;
    };
  };

  services.oauth2_proxy = let
    users = [
      "rodney.lorrimar"
      "pawel.jakubas"
      # etc. etc
    ];
  in {
    enable = true;
    provider = "google";
    email.domains = [ "iohk.io" ];
    email.addresses = lib.concatMapStringsSep "\n" (u: "${u}@iohk.io") users;
    reverseProxy = true;
    nginx.virtualHosts = [ domain hosts.monitoring ];
    passAccessToken = true;

    keyFile = config.deployment.keys.iohk_oauth2_proxy.path;
    cookie.name = "_oauth2_proxy";
    # cookie.domain = ".adrestia.iohkdev.io";
    cookie.secure = true;
  };

  users.users.oauth2_proxy.group = lib.mkDefault "oauth2_proxy";
  users.groups.oauth2_proxy = {};

  rodnix.key-deps.iohk_oauth2_proxy = [ "oauth2_proxy" ];
}
