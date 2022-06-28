{
  description = "Adrestia Project Tools";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    flake-compat = {
      url = github:edolstra/flake-compat;
      flake = false;
    };
    emanote = {
      url = "github:srid/emanote";
    };
    ema = {
      url = "github:srid/ema";
    };
  };

  outputs = { self, nixpkgs, flake-utils, emanote, ... }:
    flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      flake = {
        devShell = flake.devShells.default;
        devShells = {
          default = pkgs.mkShell {
            name = "adp";
            nativeBuildInputs = [
              emanote.packages.${system}.default
              pkgs.yq
              (pkgs.callPackage ./nix/hedgedoc-cli/package.nix {
                server = "https://md.adrestia.iohkdev.io";
              })
              (pkgs.writeScriptBin "nixops" ''
                echo "Sorry, wrong directory - cd infra"
                exit 1
              '')
            ];
          };
        };

      };
    in
      flake);

  nixConfig = {
    bash-prompt = "\\u@\\h:\\w \[$name\] \\$ ";
    extra-substituters = "https://adp.cachix.org";
    extra-trusted-public-keys = "adp.cachix.org-1:3dW4Tyn1E3O9B+VMcgSXAInOt8FEvLPq+YdxM+cPwr0=";
  };
}
