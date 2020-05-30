# Adrestia Weekly Report

<p align="right">
  <strong>Week 22</strong>: 2020/05/25 → 2020/05/29
</p>

# Project Overview

## ⛅ Forecast

### 2020/06/02

- (ADP-291) Document error conditions of API endpoints
- (ADP-244) Cardano decentralization progress
- (ADP-319) Continue integrating with Shelley node: Transaction support

### 2020/06/09

- (ADP-157) Manage key registration certificates w/ cardano-node

### 2020/06/09

- (ADP-244) Shelley activation countdown
- (ADP-93) Transaction Scheduler

# Past Week Overview

#### cardano-wallet | latest = [v2020-05-06](https://github.com/input-output-hk/cardano-wallet/releases/v2020-05-06)

- Added migration endpoint to the Shelley part of the API, so that one can easily migrate a Shelley wallet to another.

- Some minor API documentation improvements and fixes, using feedback from exchanges and users raising questions on Slack.

- Fixed [#1670](https://github.com/input-output-hk/cardano-wallet/issues/1670) where input resolution would not be done 
  over the entire database (but only on the fetched data).

- Bumped version & integration with cardano-node, closely following the pioneer releases.

- Scripted some Nix magic to ease the access to various cardano-node deployment information.

- Revised the `getNetworkParameters` endpoint, and removed the extraneous "epochId" path parameter. Then, added a
  "decentralizationLevel" indicator to the set of returned parameters.

- Continue working on cardano-node support. The wallet can now send and receive basic UTxO transactions. We hit walls 
  several time, in particular regarding fee calculation which made progress hard. Most integration tests are now passing
  but some are still failing and we are fixing things one by one. In the meantime, we are adding support for delegation 
  certificates and stake pool listing.

#### cardano-graphql | latest = [1.0.0-rc10](https://github.com/input-output-hk/cardano-graphql/releases/tag/v1.0.0-rc.10)

- Fixed bug regarding transaction ordering. 

#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = N/A

- Added support for cardano-node in Shelley mode, connected to cardano-wallet-shelley.
- Automated the package delivery workflow to reduce the number of steps post-release.

#### cardano-coin-selection | latest = [1.0.1](https://github.com/input-output-hk/cardano-graphql/releases/1.0.1)

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- ø

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- ø

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Friendly command-line interface for doing HD derivation in the console for any type of Cardano wallet. Commands are simple 
  and play well together. Include multiple output encoding and nice error handling. For example, one can create a recovery
  phrase and obtain its associated reward account public key very easily:

  ```console
  $ cardano-address recovery-phrase generate --size 15 > recovery-phrase.prv
  $ cat recovery-phrase.prv \
    | cardano-address key from-recovery-phrase Shelley \
    | cardano-address key child 1852H/1815H/0H/2/0 \
    | cardano-address key public 
  xpub16y4vhpyuj2t84gh2qfe3ydng3wc37yqzxev6gce380fvvg47ye8um3dm3wn5a64gt7l0fh5j6sjlugy655aqemlvk6gmkuna46xwj9g4frwzw
  ```

- Pointer addresses support added to the Shelley style. Command-line for address creation and inspection is on its way.

# Known Issues / Debts

- ø
