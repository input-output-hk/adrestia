{
  rodnix.users.primary = {
    name = "adrestia";
    fullName = "Adrestia";
    extraConfig.hashedPassword = ""; # login locally without a password
    sshKeys = [
      ../pubkeys/rvl.pub
      ../pubkeys/sevanspowell.pub
      ../pubkeys/anviking.pub
    ];
  };
}
