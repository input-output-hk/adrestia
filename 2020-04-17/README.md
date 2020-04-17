# Adrestia Weekly Report

<p align="right">
  <strong>Week 16</strong>: 2020/04/13 → 2020/04/17
</p>

# Project Overview

## :rocket: Latest release

cardano-wallet                                                                    | Jörmungandr                                                                    | cardano-node
---                                                                               | ---                                                                            | ---
[v2020-04-07](https://github.com/input-output-hk/cardano-wallet/tree/v2020-04-07) | [v0.8.15](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.15) | [1.9.3](https://github.com/input-output-hk/cardano-node/releases/tag/1.9.3)

## ⛅ Forecast

### 2020/04/21

- (ADP-184) GraphQL: postman use cases/scenarios
- (ADP-187) GraphQL: postman use cases/scenarios
- (ADP-83) Local State Query Protocol integration

### 2020/04/28

- (ADP-157) Manage key registration certificates
- (ADP-158) Shelley address format 

# Past Week Overview

## :newspaper: Non-Technical Summary

#### cardano-wallet

- :bug: Fixed Generated an unbalanced tx! Too much left for fees [#1561](https://github.com/input-output-hk/cardano-wallet/issues/1561)
- :bug: Fixed transaction history being inconsistent with sparse checkpoints when rolling back to an unknown point [#1575](https://github.com/input-output-hk/cardano-wallet/issues/1575)
- Add a new 'discovery' field (random vs sequential) to the legacy wallet to allow discriminating them from the API (and show / not show features depending on the type of discovery scheme being used)
- Removed last redundant / unused jobs from hydra. It's been a long way but we know have no less than 123 succeeding jobs on hydra, managing cross-compilation and test of the cardano-wallet on all platforms. And passing!

#### cardano-launcher

- Support storing logs in separate files.
- Allowed the 'Byron' integration to use TLS optionally to ease testing setup.
- Enabled clean shutdown for Byron cardano-node through `cardano-launcher`.

#### cardano-coin-selection

> [:book: library documentation](https://input-output-hk.github.io/cardano-coin-selection/haddock/)

- Add tests and increase test coverage regarding some internal type representation of the coin selection.
- Disabled the automatic algorithm fallback from random-improve to largest first. This decision will be left to callers.
- Migrate CI from 'Travis' to 'Github Actions', and compute & [export code coverage](https://input-output-hk.github.io/cardano-coin-selection/coverage/hpc_index.html) on each build. 
- Reworked internals to use an unbounded 'Natural' instead of a bounded 'Word64'. Doing so, we've discovered a few interesting cases
  where the test code would actually hit some overflow / underflow. 

#### cardano-transactions

> [:book: library documentation](https://input-output-hk.github.io/cardano-transactions/haddock/)

- Add code coverage as part of the continuous integration, report exported [here](https://input-output-hk.github.io/cardano-transactions/coverage/hpc_index.html)
- Provide an [end-to-end example](https://github.com/input-output-hk/cardano-transactions/wiki/How-to-submit-transaction-via-cardano-tx-CLI) of using the `cardano-tx` 
  and `cardano-wallet` command-lines for building, signing and submitting a transaction to Cardano!

#### cardano-addresses

> [:book: library documentation](https://input-output-hk.github.io/cardano-addresses/haddock/)

- Wrapped up library's API to offer:
  - address hard and soft (when available) derivations for Byron and Icarus styles
  - address construction from public keys
  - mnemonic to master key generation for Byron, Icarus, Trezor and Ledger wallets
  - user-facing encoding of addresses, base58 or bech32 

- The library offers a simple but type-safe API to help developer constructing valid addresses, and guiding them through the steps of key generation, derivation and signing. The library is obviously fully tested. 
  And code coverage is also computed and reported [here](https://input-output-hk.github.io/cardano-addresses/coverage/hpc_index.html).

# Next Week Planning

## :hammer:

- Get `cardano-graphQL` in a state where it is ready-for-production (in terms of testing and documentation).

- Continue integration of the local state protocol.

- Publish libraries on hackage, after adding some clearer examples

- Finalize the exchange integration guide and give pointers about the services and libraries.

- A possible rewrite / revision of some of the internal logic of the wallet backend to enable an easier testing of the interaction between rollbacks and sparse checkpoints.

- Some first experiments with GHC-JS and tanspiling the Haskell libraries to JS

# Known Issues / Debts

- Cannot force resync wallet and cardano-node crash as a result [#1505](https://github.com/input-output-hk/cardano-wallet/issues/1505)
- Depth shouldn't be calculated for pending transaction [#1563](https://github.com/input-output-hk/cardano-wallet/issues/1563)
- Submit transaction on staging_shelley gives 500 [#1492](https://github.com/input-output-hk/cardano-wallet/issues/1492)
