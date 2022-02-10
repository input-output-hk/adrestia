---
title: 03-Create a Development Environment
date: 2021-02-09
---

## Hacking

`nix-shell` has been replaced by `nix develop`, and by default it builds the attribute `devShell.x86_64-linux`, so a simple python development environment would look like this:

`flake.nix`
```
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux
    in {
      devShell.x86_64-linux = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.python3
        ];
      };
    };
}
```

We could then run `nix develop` and we would enter a shell with access to python.
