# Adrestia Infrastructure

Here are the sources for our deployment at [adrestia.iohkdev.io](https://adrestia.iohkdev.io).

## Getting started

Either use `nix develop` to get an infra shell, or enable `nix-direnv`.

## Deployment credentials

The deployment keys are fetched from our shared folder in
[Vaultwarden](https://vaultwarden.iog.io) using the `bw` CLI.

Run `bw login` then save the `BW_SESSION=...` value into `.state/session.env`.

Test that credential fetching is working with:

```console
$ ./scripts/fetch.sh adrestia_test
It works!
```

## Create deployment

Run `update-nixops` to set up the nixops database and install necessary AWS
credentials.

