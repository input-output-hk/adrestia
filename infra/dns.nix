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
}
