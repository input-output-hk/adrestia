Installation Instructions
=========================

## Using Docker (recommended)

Docker images are continuously built and deployed on [dockerhub](https://hub.docker.com/u/inputoutput) under specific tags. Using docker provides **the fastest** and **easiest** user experience for setting up the Cardano stack. You should prefer this solution over building from sources unless you have really good reasons not to. The following images are available for each component of the Adrestia architecture:

| Repository                                                                                                    | Tags                                  | Documentation                                                                                |
|---------------------------------------------------------------------------------------------------------------|---------------------------------------|----------------------------------------------------------------------------------------------|
| [inputoutput/cardano-node](https://hub.docker.com/r/inputoutput/cardano-node)                                 | `master`, `MAJ.MIN.PATCH`, `latest`   | [link](https://github.com/input-output-hk/cardano-node/blob/master/nix/docker.nix#L1-L25)    |
| [inputoutput/cardano-db-sync](https://hub.docker.com/r/inputoutput/cardano-db-syncnputoutput-cardano-db-sync) | `master`, `MAJ.MIN.PATCH`, `latest`   | [link](https://github.com/input-output-hk/cardano-db-sync/blob/master/nix/docker.nix#L1-L35) |
| [inputoutput/cardano-graphql](https://hub.docker.com/r/inputoutput/cardano-graphql)                           | `master`, `MAJ.MIN.PATCH`, `latest`   | [link](https://github.com/input-output-hk/cardano-graphql/wiki/Docker)                       |
| [inputoutput/cardano-explorer-api](https://hub.docker.com/r/inputoutput/cardano-explorer-api)                 | `master`, `MAJ.MIN.PATCH`, `latest`   | [link](https://github.com/input-output-hk/cardano-rest/wiki/Docker)                          |
| [inputoutput/cardano-submit-api](https://hub.docker.com/r/inputoutput/cardano-submit-api)                     | `master`, `MAJ.MIN.PATCH`, `latest`   | [link](https://github.com/input-output-hk/cardano-rest/wiki/Docker)                          |
| [inputoutput/cardano-wallet](https://hub.docker.com/r/inputoutput/cardano-wallet)                             | `byron`, `YYYY.MM.DD-byron`, `latest` | [link](https://github.com/input-output-hk/cardano-wallet/wiki/Docker)                        |

### Semantic

| Tag                                   | Semantic                                                                                                                                                                                                                                                                                                                                            |
|---------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `latest`                              | Points to the latest __stable__ image for the corresponding component. This is also the tag to which `docker` defaults when pulling without an explicit tag. These typically points to latest known release which happens at the end of an iteration cycle. Depending on which project / component, the iteration cycle may vary from 1 to 2 weeks. |
| `MAJ.MIN.PATCH` or `YYYY.MM.DD-byron` | Must match actual releases of the corresponding component. Refer to each component release notes to know which release tags are available.                                                                                                                                                                                                          |
| `master`                              | Points to the very tip of the development branch. This is therefore __not recommended__ for production but can be useful to try out features before they are officially released.                                                                                                                                                                   |
| `byron`                               | A special tag pointing to the very tip of the development branch on `cardano-wallet`. `cardano-wallet` does support both `jörmungandr` and `cardano-node` at the same time, but corresponding images are packaged separately. The `byron` tag therefore points to a version of `cardano-wallet` compatible with cardano-node in OBFT mode.          |

### Examples

For example, in order to use `cardano-node@1.10.0`, one can simply run:

```
docker pull inputoutput/cardano-node:1.10.0
```

Similarly, one can pull `cardano-wallet@v2020-04-07` with:

```
docker pull inputoutput/cardano-wallet:v2020.4.7-byron
```

> **HINT**  _About version compatibility_

For version compatibility between components, please refer to compatibility matrix on each component main page (e.g. [cardano-wallet#latest-releases](https://github.com/input-output-hk/cardano-wallet#latest-releases)).

### Docker compose

Some components also provide example setup via [docker-compose](https://docs.docker.com/compose/). Those are useful for a quick start or as a baseline for development. See for example [cardano-wallet](https://github.com/input-output-hk/cardano-wallet/blob/master/docker-compose.yml), [cardano-graphql](https://github.com/input-output-hk/cardano-graphql/blob/master/docker-compose.yml) or [cardano-rest](https://github.com/input-output-hk/cardano-rest/blob/master/docker-compose.yml).

## Pre-compiled Artifacts / Building From Sources

In case you prefer using raw binary instead, some components do provide pre-compiled release artifacts for each release. These can be downloaded directly from the github servers, via the UI or using a command-line tool like `wget` or `cURL`. For example, one can download a pre-packaged linux binary for `cardano-wallet@v2020-04-07` via:

```
curl -L https://github.com/input-output-hk/cardano-wallet/releases/download/v2020-04-07/cardano-wallet-v2020-04-07-linux64.tar.gz | tar xz

./cardano-wallet-byron-linux64/cardano-wallet --help
The CLI is a proxy to the wallet server, which is required for most commands.
Commands are turned into corresponding API calls, and submitted to an
up-and-running server. Some commands do not require an active server and can be
run offline (e.g. 'mnemonic generate').

[...]
```

If you feel brave enough and want to compile everything from sources, please refer to each repository's documentation. As a pre-requisite, you may want to install and configure [Nix](https://nixos.org/), [stack](https://docs.haskellstack.org/en/stable/README/) or [cabal](https://www.haskell.org/cabal/) depending on your weapon of choice. Build instructions are available on each repository's main README.

Repository                                                              | Releases                                                                | Linux | MacOS | Windows
------------------------------------------------------------------------|-------------------------------------------------------------------------|-------|-------|--------
[cardano-node](https://github.com/input-output-hk/cardano-node)         | [releases](https://github.com/input-output-hk/cardano-node/releases)    | ✔️     | ✔️     | ✔️
[cardano-db-sync](https://github.com/input-output-hk/cardano-db-sync)   | [releases](https://github.com/input-output-hk/cardano-db-sync/releases) | ✔️     | ✔️     | ❌
[cardano-submit-api](https://github.com/input-output-hk/cardano-rest)   | [releases](https://github.com/input-output-hk/cardano-rest/releases)    | ✔️     | ✔️     | ❌
[cardano-explorer-api](https://github.com/input-output-hk/cardano-rest) | [releases](https://github.com/input-output-hk/cardano-rest/releases)    | ✔️     | ✔️     | ❌
[cardano-graphql](https://github.com/input-output-hk/cardano-graphql)   | [releases](https://github.com/input-output-hk/cardano-graphql/releases) | ✔️     | ✔️     | ❌
[cardano-wallet](https://github.com/input-output-hk/cardano-wallet)     | [releases](https://github.com/input-output-hk/cardano-wallet/releases)  | ✔️     | ✔️     | ✔️
