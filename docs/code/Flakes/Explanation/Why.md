---
title: Why Flakes?
date: 2021-02-10
---

Nix Flakes are a new feature of the "nix package manager". They unify the typical ways of declaring inputs and ouputs of a project under a common syntax.

But why use them?

## Why?

  - Unify the management of inputs (make redundant tools like `niv`).
  - Remove sources of impurity that existed in the previous model.
  - Standardize the output format of repositories.
    - A Nix expression typically creates a "package" for a repository, for example, the cardano-wallet expression creates a binary package which is available at "cardano-wallet". The location of the attribute in the output attribute set is completely arbitrary. Another repository might put their "package" at "packages.cardano-doohickey".
    - Nix flakes attempt to standardize the typical output locations of a Nix expression, so that packages are always available at the same location.

## Concepts

From an abstract point of view, a derivation in Nix is a function from inputs to ouputs. Inputs are typically libraries and executables, and the output is typically another library or executable.

Flakes extend the input/output model of derivations to the entire repository. A single file sits at the root of the repository called `flake.nix`, that might look something like this:

```
{
  description = "Example flake";

  inputs = {
    cardano-db-sync.url = "github:input-output-hk/cardano-db-sync?ref=refs/tags/12.0.0";
    haskellNix.url = "github:input-output-hk/haskell.nix";
    # ... other inputs
  };

  outputs = { cardano-db-sync, haskellNix }: {
    packages.x86_64-linux.linode-cli = pkgs.python3Packages.callPackage ./pkgs/linode-cli.nix {};
    # ... other outputs
  };
}
```

It's conceptually quite simple. Given these inputs, this repository produces a set of outputs.

IOHK previously made use of `niv`, `niv` was just a different method of pinning inputs that wrote to the file "sources.json". The flakes model isn't necessarily "better" than `niv`, but flakes have other benefits.

By running `nix flake lock`, the inputs of the repository are pinned down to specific revisions and SHAs and written to `flake.lock`.

