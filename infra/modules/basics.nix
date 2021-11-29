{ lib, pkgs, config, ... }: {
  rodnix.enable = true;

  services.openssh = {
    enable = true;
    forwardX11 = false;
    passwordAuthentication = false;
    permitRootLogin = "prohibit-password";
  };

  users.defaultUserShell = pkgs.zsh;

  # Install terminfo files for urxvt users.
  environment.systemPackages = [ pkgs.rxvt-unicode ];
}
