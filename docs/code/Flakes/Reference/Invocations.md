---
title: Invocations and Pathing
date: 2021-02-10
---

## Invocations

`nix-build` is now `nix build`

`nix-shell` is now `nix develop`

`nix-repl default.nix` is now:

```
$ nix repl
> :lf .
# Get some information:
> legacyPackages.x86_64-linux.pkgs.stdenv.hostPlatform.libc
# Build cardano-wallet:
> :b packages.x86_64-linux.cardano-wallet
```

## Pathing

`nix-build -A cardano-wallet` is now `nix build .#packages.x86_64-linux.cardano-wallet`

i.e.

```
nix build $FLAKE_PATH
$FLAKE_PATH = $PATH_TO_FLAKE_FILE#$ATTRIBUTE
$FLAKE_PATH = .#packages.x86_64-linux.cardano-cli
```

The `$PATH_TO_FLAKE_FILE` can be quite complicated:

```
  · .: The flake in the current directory.
  · /home/alice/src/patchelf: A flake in some other directory.
  · nixpkgs: The nixpkgs entry in the flake registry.
  · nixpkgs/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293: The nixpkgs entry in the flake registry, with its Git revision overridden to a specific value.
  · github:NixOS/nixpkgs: The master branch of the NixOS/nixpkgs repository on GitHub.
  · github:NixOS/nixpkgs/nixos-20.09: The nixos-20.09 branch of the nixpkgs repository.
  · github:NixOS/nixpkgs/a3a3dda3bacf61e8a39258a0ed9c924eeca8e293: A specific revision of the nixpkgs repository.
  · github:edolstra/nix-warez?dir=blender: A flake in a subdirectory of a GitHub repository.
  · git+https://github.com/NixOS/patchelf: A Git repository.
  · git+https://github.com/NixOS/patchelf?ref=master: A specific branch of a Git repository.
  · git+https://github.com/NixOS/patchelf?ref=master&rev=f34751b88bd07d7f44f5cd3200fb4122bf916c7e: A specific branch and revision of a Git repository.
  · https://github.com/NixOS/patchelf/archive/master.tar.gz: A tarball flake.
```
