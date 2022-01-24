{
  description = "Hedgedoc command-line interface";

  inputs = {
    hedgedoc-cli-src = {
      url = github:hedgedoc/cli;
      flake = false;
    };
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, hedgedoc-cli-src, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage = self.packages.${system}.hedgedoc-cli;
      packages.hedgedoc-cli = nixpkgs.legacyPackages.${system}.callPackage ./package.nix {
        inherit hedgedoc-cli-src;
      };
    });
}
