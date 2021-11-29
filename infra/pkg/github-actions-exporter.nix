{ buildGoModule, fetchFromGitHub, lib, ... }:

buildGoModule rec {
  name = "github-actions-exporter";

  # https://github.com/Spendesk/github-actions-exporter/pull/28
  # other options:
  # https://github.com/kaidotdev/github-actions-exporter
  # https://github.com/kronostechnologies/prometheus-exporter-github
  src = fetchFromGitHub {
    # owner = "Spendesk";
    owner = "DerTiedemann";
    repo = "github-actions-exporter";
    rev = "2230509abcdb90682b95fda8b516482743a4b60e";
    sha256 = "sha256-7ImhDhOwIKt7kG21rCHMZuiH+o+8pQKWZdvIRBCfy8A=";
  };

  vendorSha256 = "sha256-RPO1JsW4d0+GNd3ul/QQgXb+WQvKV07GfpNplp1UHpQ=";

  runVend = true;

  meta = with lib; {
    homepage = "https://github.com/Spendesk/github-actions-exporter";
    license = licenses.mit;
    maintainers = with maintainers; [ rvl ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
