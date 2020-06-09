# Adrestia Weekly Report

<p align="right">
  <strong>Week 23</strong>: 2020/06/01 → 2020/06/05
</p>

# Project Overview

## ⛅ Forecast

### 2020/06/09

- (ADP-291) Document error conditions of API endpoints
- (ADP-244) Cardano decentralization progress
- (ADP-157) Manage key registration certificates w/ cardano-node

### 2020/06/16


# Past Week Overview

#### cardano-wallet | latest = [v2020-05-06](https://github.com/input-output-hk/cardano-wallet/releases/v2020-05-06)

- Finalized Shelley "basic" (i.e. UTxO payments) transaction layer and testing. We however discovered that "genesis stake pools" aren't a thing like in Jörmungandr. Leaders registered in the genesis file aren't _pools_ but are BFT leaders. Therefore, most of the integration testing so far has happened on BFT shelley leaders. Setting up pools for integration testing is quite some work.

- First foundational work on the test integration setup to get a cluster of stake pool running. Getting there, but pools require to be registered and have funds delegate to them. So that's basically 3 certificates to create and funds to move around. 

- Initial implementation of delegation in Shelley, although not properly testable until we have finalized the work on the test cluster. 

- Cleaned up protocol parameters and now report the decentralization level (d parameter) from "live data" (so far, the parameter was hard-wired, it is now properly fetched from the local state query protocol from a running local node).

- Bumped the wallet integration to work with cardano-node-1.13.1. 

- Fixed [#1701](https://github.com/input-output-hk/cardano-wallet/issues/1701) where
  already existing Shelley wallets would wrongly report as having no passphrase; a missing albeit necessary database migration had escaped our vigilance. 

- Improved Hydra evaluation time (~30%), making CI a bit more bearable.

- Enabled restoration from extended account public key also on _Byron_ sequential wallets (a.k.a Icarus) to make it possible to test hardware wallet integration on _Byron_ while the _Shelley_ hardware applications are being developed.

- Struggled with releases. We've made several attempts at releasing this week but we are hitting the limits of the free-tier on [Travis](travis-ci.org/) on which we still depend to create releases. We've been willing to get away from Travis and work on more reliable solution but time and resources are missing to do this. Compiling 3 versions of cardano-wallet (Jörmungandr, Byron & Shelley) is somewhat heavy.

#### cardano-graphql | latest = [1.0.0-rc10](https://github.com/input-output-hk/cardano-graphql/releases/tag/v1.0.0-rc.10)

- Fixed bug regarding transaction ordering. 

#### cardano-rest | latest = [2.0.0](https://github.com/input-output-hk/cardano-rest/releases/2.0.0)

- ø

#### cardano-launcher | latest = N/A

- ø

#### cardano-coin-selection | latest = [1.0.1](https://github.com/input-output-hk/cardano-graphql/releases/1.0.1)

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- ø

#### cardano-transactions | latest = [1.0.0](https://github.com/input-output-hk/cardano-transactions/releases/1.0.0)    

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- ø

#### cardano-addresses | latest = [1.0.0](https://github.com/input-output-hk/cardano-addresses/releases/1.0.0)

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Added commands for address manipulation and inspection. The result is pretty neat and offer a nice high-level API
  for dealing with Cardano addresses, in all eras.

  ```console
  $ cardano-address recovery-phrase generate --size 15 \
    | cardano-address key from-recovery-phrase Shelley > root.prv
  
  $ cat root.prv | cardano-address key child 1852H/1815H/0H/2/0 > stake.prv
  $ cat root.prv | cardano-address key child 1852H/1815H/0H/0/0 > addr.prv

  $ cat addr.prv \
    | cardano-address key public \
    | cardano-address address payment --network-tag 0 \
    | cardano-address address delegation $(cat stake.prv | cardano-address key public) \
  addr1qpj2d4dqzds5p3mmlu95v9pex2d72cdvyjh2u3dtj4yqesv27k...

  $ cardano-address address inspect <<< "addr1qpj2d4dqzds5p3mmlu95v9pex2d72cdvyjh2u3dtj4yqesv27k..."
  address style:      Shelley
  address type:       base
  spending key hash:  79467c69a9ac66280174d09d62575ba955748b21dec3b483a9469a65
  stake key hash:     cc339a35f9e0fe039cf510c761d4dd29040c48e9657fdac7e9c01d94
  network tag:        0
  ```

# Known Issues / Debts

- ø
