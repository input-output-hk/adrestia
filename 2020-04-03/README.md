# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 14</strong>: 2020/03/30 → 2020/04/03
</p>

# Project Overview

## :rocket: Latest release

cardano-wallet                                                                    | Jörmungandr                                                                    | cardano-node
---                                                                               | ---                                                                            | ---
[v2020-04-01](https://github.com/input-output-hk/cardano-wallet/tree/v2020-04-01) | [v0.8.15](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.15) | [1.9.3](https://github.com/input-output-hk/cardano-node/releases/tag/1.9.3)

- (#1292) Wallets disappear from list when their worker dies unexpectedly 
- (ADP-97)  Automated nightly syncing tests with Byron TestNet / MainNet
- (ADP-105) Wallet: Client authentication (TLS)
- (ADP-189) Coin Selection: Public Specification
- (ADP-191) Recovery phrase verification
- (ADP-210) Restoration of legacy wallets from keystore 
- (ADP-211) JavaScript library for parsing cardano-sl's UserSecret 
- (ADP-211) Random address derivation through the API   
- (ADP-223) Byron wallet CRUD operations (update-name, update-spending password)
- (ADP-224) Byron wallet UTXO statistics
- (ADP-227) network/information does not work on cardano-node until one creates a wallet
- (ADP-228) Wallet re-syncs from 0% after restarting cardano-wallet-byron
- (ADP-229) CLI support for Byron wallet
- (ADP-230) Cannot send transaction on testnet (cardano-node + cardano-wallet-byron)
- (ADP-231) Restarting cardano-node while cardano-wallet is running breaks cardano-wallet

## ⛅ Forecast

### 2020/04/07

- (ADP-233) Cannot force resync wallet and cardano-node crash as a result
- (ADP-235) Submit transaction on staging_shelley gives 500
- (ADP-237) Icarus wallets are created with Mainnet addresses even if the server is in 'Testnet' mode

### 2020/04/14

- (ADP-28) Library/SDK: Address Derivation 
- (ADP-31) Library/SDK: Mnemonics
- (ADP-32) Transaction Builder (Payment)
- (ADP-213) Coin Selection: Library Reuse

### 2020/04/21

- (ADP-83) Local State Query Protocol integration
- (ADP-158) Shelley address format 
- (ADP-157) Manage key registration certificates

# Past Week Overview

## :newspaper: Non-Technical Summary

Wrapping up the integration with cardano-node. The team has worked on many fronts during the last past two weeks:

- Closed gaps in the Byron API to fully enable Daedalus Flight. The [cardano-wallet API](https://input-output-hk.github.io/cardano-wallet/api/edge) now counts no less than 38 endpoints and works as
  an interface for both Jörmungandr and cardano-node, to serve Byron, Icarus, Trezor, Ledger and ITN wallets! This is **huge**. 

- Wired [full command-line support](https://github.com/input-output-hk/cardano-wallet/wiki/Wallet-Command-Line-Interface-(cardano-wallet-byron)) for Byron wallets through cardano-node. 

- Finalized the JavaScript launcher library which enables Daedalus to spawn and monitor multiple processes from JavaScript directly
  and without fragile and ad-hoc Inter-Process Communication (IPC). The launcher is fully tested cross-platforms and also works
  with both jörmungandr and cardano-node. 

- Improved the continuous integration setup so that we can, automatically:

  - Build, test and distribute cardano-wallet with Jörmungandr on all three supported platforms.
  - Build, test and distribute cardano-wallet with cardano-node on all three supported platforms.
  - Run nightly database and API benchmarks.
  - Run nightly database migrations tests ensuring compatibility of new releases with old releases.
  - Run and monitor nightly synchronization of cardano-wallet w/ cardano-node against mainnet on trivial and non-trivial wallets.

- Extended cardano-js with JavaScript / TypeScript functions to enable Daedalus to manipulate mnemonic, generate root 
  master keys (Icarus & Byron) and generate wallet identifiers

- Completed [the first draft](https://github.com/input-output-hk/cardano-coin-selection/blob/82edb7e48b5e783348ce85f10e5887caca418f6d/information/specification.md) of the coin selection library exposing a clear specification of coin selection algorithms implemented in cardano-wallet alongside properties and clear terminology.


## :bug: Bug Fixes

- Wallets disappear from list when their worker dies unexpectedly [#1292](https://github.com/input-output-hk/cardano-wallet/issues/1292)
- Wallet restoration extremely slow on Windows [#1398](https://github.com/input-output-hk/cardano-wallet/issues/1398)
- Restarting cardano-node while the wallet is running breaks cardano-wallet [#1468](https://github.com/input-output-hk/cardano-wallet/issues/1468)
- Wallet re-syncs from genesis after restarting cardano-wallet-byron [#1453](https://github.com/input-output-hk/cardano-wallet/issues/1453)
- Cannot send transaction on testnet (cardano-node + cardano-wallet-byron) [#1462](https://github.com/input-output-hk/cardano-wallet/issues/1462)

# Next Week Planning

## :hospital: Recovery week. 

Bug fixes and housekeeping.

# Known Issues / Debts

- (ADP-233) Cannot force resync wallet and cardano-node crash as a result
- (ADP-235) Submit transaction on staging_shelley gives 500
