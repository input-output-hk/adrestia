---
title: Installation
date: 2021-02-09
order: 1
---

Presuming nix is already installed, Nix flakes are available from Nix version 2.4 and up.

## Non-NixOS

```
$ nix-env -iA nixpkgs.nixUnstable # or nixpkgs.nix_2_4
                                  # or nixpkgs.nix_2_5
                                  # or nixpkgs.nix_2_6, etc.
```

Then edit either `~/.config/nix/nix.conf` or `/etc/nix/nix.conf` and add:

```
experimental-features = nix-command flakes
```

## NixOS

Add the following to your NixOS configuration:

`/etc/nixos/configuration.nix`
```
  nix = {
    package = pkgs.nixUnstable; # or pkgs.nix_2_4
                                # or pkgs.nix_2_5
                                # or pkgs.nix_2_6, etc.
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
```

Then

`nixos-rebuild switch`
