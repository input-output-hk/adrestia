{
  aws = {
    accessKeyId = "adrestia";
  };
  gce = {
    project = "iohk-323702";
    serviceAccount = "nixops@iohk-323702.iam.gserviceaccount.com";
  };
  oauth2.clientId = "541800443777-he88i3kknr58qdhujd1q8c2gqcsjj04p.apps.googleusercontent.com";
  keys = [
    "iohk_oauth2_proxy"
    "iohk_oauth2_matrix"
    "iohk_oauth2_client_secret"
    "borgbackup-gce-mob-dev"
    "iohk_hedgedoc"
    "mob-dev-ssh_host_rsa_key"
    "mob-dev-ssh_host_ed25519_key"
    "iohk_grafana_admin_password"
    "iohk_grafana_secret_key"
    "iohk_alertmanager_matrix_token"
    "iohk_matrix_registration_shared_secret"
    "iohk_github_actions_exporter_token"
    "iohk_s3backup"
  ];
}
