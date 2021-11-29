{ buildGoModule, fetchgit, lib, ... }:

buildGoModule rec {
  name = "alertmanager-matrix";

  # src = fetchgit {
  #   url = "https://git.slxh.eu/Prometheus/alertmanager_matrix.git";
  #   rev = "f54688678029719d9a565fda190ec933c6ce3fc4";
  #   sha256 = "sha256-wyvJi6A4z6hKNXyyoSg4s2jU1ExjTwGvyICcVqHrnKM=";
  # };
  # https://github.com/silkeh/alertmanager_matrix/pull/2
  src = fetchgit {
    url = "https://github.com/Rudd-O/alertmanager_matrix.git";
    rev = "84396477490c7f5568a8fc8fc128e0c9899c5cdb";
    sha256 = "sha256-qnPsgv7UFE3afFJyTZfzZ4k1hwbDcVCcy7/KheOYmbc=";
  };

  vendorSha256 = "sha256-vY4QKR88AG8J3/YaQtZosDmzUgaj3439Lkp+GZf782Y=";

  runVend = true;

  meta = with lib; {
    description = ''
      Service for sending alerts from the Alertmanager webhook to a
      Matrix room and managing Alertmanager.
    '';
    homepage = "https://git.slxh.eu/Prometheus/alertmanager_matrix";
    license = licenses.eupl12;
    maintainers = with maintainers; [ rvl ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
