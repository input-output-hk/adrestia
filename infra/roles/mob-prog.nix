{ flakeInputs, ... }:

{
  imports = [
    flakeInputs.iohk-binary-cache.nixosModule
    flakeInputs.basic.roles.base
    flakeInputs.basic.roles.term
    flakeInputs.basic.roles.basic-dev

    ../modules/adrestia-users.nix
  ];

  my.imports = [
    ../hm-modules/fetch-repos.nix
  ];
}
