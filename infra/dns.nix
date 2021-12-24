{ lib }: rec {
  hostName = "adrestia";
  domain = "iohkdev.io";

  zone = "${hostName}.${domain}";

  hosts = { ${hostName} = zone; } // lib.genAttrs [
    "matrix"
    "element"
    "jitsi"
    "turn"
    "md"
    "monitoring"
  ] (host: "${host}.${zone}");

  # hardcoded because I don't know how to get it from nixops!
  ipv4.gce-mob-dev = "34.151.124.220";
}
