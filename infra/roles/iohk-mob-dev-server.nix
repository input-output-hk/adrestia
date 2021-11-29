{
  imports = [
    ../modules/chat.nix
    ../modules/video-calling.nix
    ../modules/collaborative-editing.nix
    ../modules/web.nix
    ../modules/database.nix
    ../modules/nix-store.nix
    ../modules/backup.nix
    ../modules/monitoring.nix
  ];

  # ssh-keygen -t ed25519 -C "mob-dev_ssh_host_key" -f mob-dev_ssh_host_ed25519_key -P ""
  deployment.keys = {
    mob-dev-ssh_host_rsa_key = { destDir = "/etc/ssh"; name = "ssh_host_rsa_key"; };
    mob-dev-ssh_host_ed25519_key = { destDir = "/etc/ssh"; name = "ssh_host_ed25519_key"; };
  };

  users.users.root.openssh.authorizedKeys.keyFiles = [
    ../pubkeys/rvl.pub
  ];
}
