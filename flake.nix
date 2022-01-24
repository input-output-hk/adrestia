{
  description = "Adrestia Project Tools";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    emanote.url = github:srid/emanote;
    hedgedoc-cli = {
      url = path:./nix/hedgedoc-cli;
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, emanote, hedgedoc-cli }:
    flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      flake = {
        devShell = flake.devShells.default;
        devShells = {
          default = pkgs.mkShell {
            name = "adp";
            nativeBuildInputs = [
              emanote.defaultPackage.${system}
              pkgs.yq
              (hedgedoc-cli.defaultPackage.${system}.override {
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

  nixConfig.bash-prompt = "\\u@\\h:\\w \[$name\] \\$ ";
}
