{ pkgs, flakeInputs, ... }: {
  rodnix.enable = true;
  rodnix.repo = toString flakeInputs.rvl.sourceInfo;

  services.openssh = {
    enable = true;
    forwardX11 = false;
    passwordAuthentication = false;
    permitRootLogin = "prohibit-password";
  };

  users.defaultUserShell = pkgs.zsh;

  # Install terminfo files for urxvt users.
  environment.systemPackages = [ pkgs.rxvt-unicode ];

  users.users.root.openssh.authorizedKeys.keyFiles = [
    ../pubkeys/rvl.pub
  ];
}
