rec {
  description = "Adrestia development infrastructure";

  inputs = {
    rvlConfig = {
      type = "git";
      url = "https://git.lorrimar.id.au/rodney/config.git";
      flake = false;
    };

    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, flake-utils, rvlConfig, home-manager }: let
    inherit (nixpkgs) lib;

    rodnix = import "${rvlConfig}/rodnix/default.nix" {};

    flakes = flake-utils.lib.eachDefaultSystem (system: let

      # Make a package set with all our overlays.
      pkgs = import nixpkgs {
        inherit system;
        overlays = rodnix.overlays ++ lib.attrValues overlays;
      };

      overlays = {
        cherrypick-unstable = self: super: {
          inherit (nixpkgsUnstable.legacyPackages.${system})
            element-web;
        };
      };

      shellScripts = pkgs.makeShellScripts {
        update-nixops = ''
          cd "$top"

          if nixops info >& /dev/null; then
            cmd=modify
          else
            cmd=create
          fi

          nixops $cmd -d "$NIXOPS_DEPLOYMENT" --flake .
          nixops set-args --arg gceAccessKeyFile ./secrets/gce-nixops-key

          nixops list

          for thing in aws_access_key_id aws_secret_access_key; do
            value=$(./scripts/fetch.sh adrestia_$thing)
            aws configure --profile="$AWS_PROFILE" set $thing "$value"
          done

          aws configure list
        '';
      };

      nixops = nixpkgs.legacyPackages.${system}.nixopsUnstable;

      flake = {
        legacyPackages = pkgs;
        packages = shellScripts;

        devShell = flake.devShells.default;
        devShells = {
          default = pkgs.mkShell rec {
            name = "adp-infra";
            buildInputs = [
              nixpkgsUnstable.legacyPackages.${system}.nix
              nixops
            ] ++ (with pkgs; [
              google-cloud-sdk
              bitwarden-cli
              coreutils
            ] ++ lib.attrValues shellScripts);

            NIXOPS_DEPLOYMENT = "adp-infra";
            AWS_PROFILE = "adrestia";

            BW_ORGANIZATION_ID = "3bbffbd9-f0f8-4fb7-9d18-cca627081df0";
            BW_COLLECTION_ID = "de029761-b704-40c7-a106-105cde4b5a35";
            BW_FOLDER_ID = "59643128-fa70-4e8b-adac-496d6782cb66";

            shellHook = ''
              export top=$(${pkgs.gitMinimal}/bin/git rev-parse --show-toplevel)/infra

              # Use a nixops state file local to this repo.
              export NIXOPS_STATE="$top/.state/${NIXOPS_DEPLOYMENT}.nixops";
              export BITWARDENCLI_APPDATA_DIR="$top/.state";

              echo "NixOps: ${nixops.version}"
              echo "State file: $(realpath --relative-to="$top" $NIXOPS_STATE)"
              echo
            '';
          };
        };
      };

      in flake);
  in flakes // {
      nixopsConfigurations.default = { gceAccessKeyFile ? null }:
        import ./deployment.nix {
          inherit gceAccessKeyFile description home-manager rvlConfig;
          nixpkgs = {
            inherit (nixpkgs) lib;
            inherit (flakes) legacyPackages;
          };
        };
    };

  nixConfig.bash-prompt = "\\u@\\h:\\w \[$name\] \\$ ";
}
