{ lib, ... }: {

  fileSystems.nix-store = {
    mountPoint = "/nix/store";
    label = "nix-store";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
    formatOptions = "-m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard";
    neededForBoot = true;
    noCheck = true;
  };

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "daily";
      # Deletes all inactive generations in all profiles older than
      # the specified number of days.
      options = "--delete-older-than 30d";
    };
    extraOptions = let
      # Free up to 2GiB whenever there is less than 200MiB left:
      megabytes = {
        min-free = 200;
        max-free = 2048;
      };
    in lib.concatStringsSep "\n" (lib.mapAttrsToList (name: mib: ''
      ${name} = ${toString (mib * 1024 * 1024)}
    '') megabytes);
  };
}
