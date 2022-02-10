---
title: 02-Create a New Flakes Project
date: 2021-02-09
---

## Creating an example project

```
$ git init flake-tutorial
$ cd flake-tutorial
$ nix flake init
```

This will create the minimum required for a Nix flake-based project, a single file `flake.nix`:

`flake.nix`
```
{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}
```

Ensure that this file is staged in version control, otherwise Nix won't be able to find it.

This flake takes no inputs (or more accurately, a single input `nixpkgs`, which is implicit), and produces two outputs which can be built with the following commands:

`nix build .#packages.x86_64-linux.hello`

and

`nix build .` (builds the `defaultPackage`)

Note that the two outputs are for the same package (`hello` in this case).

The `hello` binary can be run with:

`./result/bin/hello`

## The lock file

You might have noticed that a `flake.lock` file has been generated in your repository.

This file pins the flake inputs to specific revisions. You should commit this file to version control.

In this case our input, `nixpkgs`, was implicit, so an arbitrary revision of nixpkgs was chosen (probably based on the version of Nix your system is running).

If we wanted more control over what version of nixpkgs is used, we could edit our flake.nix file like so:

`flake.nix`
```
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}
```

If we then run `nix flake lock`, our nixpkgs revision will be updated to the head of the `nixos-21.11` branch.

Subsequent builds will use nixpkgs v21.11 as the base set of packages.

## Building a python application

Instead of building `hello`, let's build a python application not available in `nixpkgs`: `linode-cli` (more accurately, it is available, but is out-of-date).

First copy and paste the following linode-cli derivation (the derivation is out-of-scope for this tutorial):

`linode-cli.nix`:
```
{ lib
, buildPythonApplication
, fetchFromGitHub
, fetchpatch
, fetchurl
, terminaltables
, colorclass
, requests
, pyyaml
, setuptools
}:

let

  spec = fetchurl {
    url = "https://raw.githubusercontent.com/linode/linode-api-docs/v4.111.0/openapi.yaml";
    sha256 = "0j1i4ig1gwvwg2vfydpkh5skdirmbbfqbrznaq6v7sz35bk7carl";
  };

in

buildPythonApplication rec {
  pname = "linode-cli";
  version = "5.13.2";

  src = fetchFromGitHub {
    owner = "linode";
    repo = pname;
    rev = version;
    sha256 = "10mlkkprky7qqjrkv43v1lzmlgdjpkzy3729k9xxdm5mpq5bjdwj";
  };

  # remove need for git history
  prePatch = ''
    substituteInPlace setup.py \
      --replace "version=get_version()," "version='${version}',"
  '';

  propagatedBuildInputs = [
    terminaltables
    colorclass
    requests
    pyyaml
    setuptools
  ];

  postConfigure = ''
    python3 -m linodecli bake ${spec} --skip-config
    cp data-3 linodecli/
  '';

  # requires linode access token for unit tests, and running executable
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/linode/linode-cli";
    description = "The Linode Command Line Interface";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ryantm ];
  };

}
```

Make sure to stage this file!

Modify your `flake.nix` file to build the python package:

`flake.nix`:
```
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.linode-cli =
      nixpkgs.legacyPackages.x86_64-linux.python3Packages.callPackage ./linode-cli.nix {};

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.linode-cli;

  };
}
```

We can now build the package with:

`nix build .` or `nix build .#packages.x86_64-linux.linode-cli`

And run the package with:

`./result/bin/linode-cli`
