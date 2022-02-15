{ lib, ... }: {
  # Mount a separate volume on /nix/store, to avoid running out of space on the rootfs.
  # The partition with label "nix-store" should be provisioned with nixops.
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
    gc = {
      automatic = true;
      dates = "daily";
      # Deletes all inactive generations in all profiles older than
      # the specified number of days.
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
    } // lib.mapAttrs (name: mib: mib * 1024 * 1024) {
      # Free up to 2GiB whenever there is less than 200MiB left:
      min-free = 200;
      max-free = 2048;
    };
  };
}
