{ stdenvNoCC, fetchurl, unzip, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "grafana-github-datasource";
  version = "1.0.11";
  src = fetchurl {
    name = "${pname}-${version}.zip";
    url = "https://github.com/grafana/github-datasource/releases/download/v${version}/${pname}-${version}.linux_amd64.zip";
    sha256 = "0cfr6wfbmhpf0c2dizjin6cndlnlabycvxq60i02pb0m3vc9k34g";
  };
  nativeBuildInputs = [ unzip ];
  installPhase = ''
    cp -R "." "$out"
    chmod -R a-w "$out"
    chmod u+w "$out"
  '';
  meta.homepage = "https://grafana.com/grafana/plugins/${pname}";
}
