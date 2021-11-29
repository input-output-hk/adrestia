{ lib, config, pkgs, ... }: let

  cloneReposScript = pkgs.writeShellScriptBin "clone-repos" ''
    export PATH=${lib.makeBinPath [ pkgs.git ]}
    cd "$HOME"
    for repo in cardano-wallet cardano-addresses offchain-metadata-tools cardano-haskell; do
      test -d $repo || $DRY_RUN_CMD git clone https://github.com/input-output-hk/$repo.git
    done
  '';

in {
  home.packages = [
    cloneReposScript
    pkgs.ghq
    # pkgs.gst
  ];

  programs.git = {
    extraConfig.ghq = {
      root = [ "~/src" ];
      "https://github.com/input-output-hk" = {
        vcs = "github";
        root = "~/iohk";
      };
    };
  };

  systemd.user.services.clone-repos = {
    Unit.Description = "Clone git repos";
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${cloneReposScript}/bin/clone-repos";
      Type = "oneshot";
    };
  };

}
