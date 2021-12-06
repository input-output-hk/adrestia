{ lib, stdenv, jq, wget, curl, fetchFromGitHub, src, server ? null }: let

  pname = "hedgedoc-cli";
  version = builtins.substring 0 8 src.lastModifiedDate; # Generate a user-friendly version number.

in stdenv.mkDerivation {
  name = "${pname}-${version}";
  inherit pname version src;

  buildPhase = let
    sed = lib.optionalString (server != null) "s|http://127.0.0.1:3000|${server}|g";
  in ''
    cat << 'EOF' > hedgedoc
    #! ${stdenv.shell} -e
    export PATH=${lib.makeBinPath [ jq wget curl ]}''${PATH:+':'}$PATH

    EOF
    sed -e '${sed}' bin/hedgedoc >> hedgedoc
  '';
  installPhase = ''
    install -D --mode=0755 --target-directory=$out/bin hedgedoc
    install -D --mode=0644 --target-directory=$out/share/doc README.md
    ln -s hedgedoc $out/bin/codimd
  '';
  checkPhase = ''
    hedgedoc --help
  '';
}
