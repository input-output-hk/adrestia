---
title: Nix Flake Schema
date: 2021-02-09
---

The `flake.nix` has the following schema:

```
{
  description = "A string";
  inputs = *input_schema;
  outputs = *output_schema:
}
```

## Input schema

An example input attrset:

```
{
  # A GitHub repository.
  import-cargo = {
    type = "github";
    owner = "edolstra";
    repo = "import-cargo";
  };

  import-cargo-alt.url = github:edolstra/import-cargo;

  nixpkgs.url = "nixpkgs";

  cardano-db-sync.url = "github:input-output-hk/cardano-db-sync?ref=refs/tags/12.0.0";

  nixpkgs-alt.url = "github:NixOS/nixpkgs/nixos-21.11";
}
```


## Output schema

There is a standard schema for the outputs of a flake:

```
{ self, cardano-db-sync, nixpkgs, import-cargo, ... } @ inputs: {
  # Packages built by the repository.
  #   Executed by `nix build .#<name>`
  packages."<system>"."<name>" = derivation;

  # Executed by `nix build .`
  defaultPackage."<system>" = derivation;

  # A default development shell for the project.
  #   Used by `nix develop`.
  devShell."<system>" = derivation;

  # A development shell for the project.
  #   Used by `nix develop .#<name>`
  devShells."<system>"."<name>" = derivation;

  # Hydra build jobs
  hydraJobs."<attr>"."<system>" = derivation;

  # Automated checks.
  #   Executed by `nix flake check`
  checks."<system>"."<name>" = derivation;

  # Used for nixpkgs packages, also accessible via `nix build .#<name>`
  # Typically the repository will provide the version of nixpkgs used in the repository here:
  # E.g.
  #   legacyPackages = import nixpkgs {
  #     inherit system overlays;
  #   };
  legacyPackages."<system>"."<name>" = derivation;

  # Used by `nix flake init -t <flake>#<name>`
  templates."<name>" = { path = "<store-path>"; description = ""; };

  # Default overlay, consumed by other flakes. Overlays are typically overlaid onto nixpkgs to add extra packages to the package set. Potentially for another project or for a system configuration.
  overlay = final: prev: { };

  # Same idea as overlay but a list or attrset of them.
  overlays = {};

  # Default module, consumed by other flakes. NixOS modules are used by NixOS configurations to "modularize" configuration.
  # For example, by importing the "cardano-node.nixosModule" I can run a simple node on my computer by enabling the option: "services.cardano-node.enable = true".
  nixosModule = { config }: { options = {}; config = {}; };

  # Same idea as nixosModule but a list or attrset of them.
  nixosModules = {};

  # Used with `nixos-rebuild --flake .#<hostname>`
  # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
  nixosConfigurations."<hostname>" = {};

  # Used by `nix flake init -t <flake>`
  defaultTemplate = {
    path = "<store-path>";
    description = "template description goes here?";
  };

  # Executed by `nix run .#<name>`
  apps."<system>"."<name>" = {
    type = "app";
    program = "<store-path>";
  };

  # Default application
  #   Executed by `nix run . -- <args?>`
  defaultApp."<system>" = { type = "app"; program = "..."; };
}
```
