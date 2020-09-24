{ pkgs ? import nixpkgs {}
, nixpkgs ? fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz
}:

# https://www.tweag.io/blog/2020-08-12-poetry2nix/
pkgs.poetry2nix.mkPoetryApplication {
  projectDir = ./.;
  overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
    sphinx-rtd-theme = super.sphinx-rtd-theme.overridePythonAttrs (
      old: {
        nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.nodejs ];
        preConfigure = ''
          sed -i "/'build_py'/d" setup.py
        '';
      }
    );
  });
  nativeBuildInputs = [ pkgs.poetry ];
}
