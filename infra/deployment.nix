{ nixpkgs
, gceAccessKeyFile ? null
, description ? ""
, nixosModules
}: let

  inherit (nixpkgs) lib;


in {
  inherit nixpkgs;

}
