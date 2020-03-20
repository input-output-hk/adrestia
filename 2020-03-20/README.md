# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 12</strong>: 2020/03/16 → 2020/03/20
</p>

# Project Overview

## :rocket: Latest release

cardano-wallet                                                                    | Jörmungandr                                                                    | cardano-node
---                                                                               | ---                                                                            | ---
[v2020-03-16](https://github.com/input-output-hk/cardano-wallet/tree/v2020-03-16) | [v0.8.14](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.14) | [1.6.0](https://github.com/input-output-hk/cardano-node/releases/tag/1.6.0)

- (#1442) Unable to retrieve stake-pool list 
- (ADP-192) Restore from public account key in CLI
- (ADP-220) Windows tests failing on Hydra
- (N/A) Serve cardano-wallet w/ cardano-node on any testnets

## ⛅ Forecast

### 2020/03/24

- (#1292) Wallets disappear from list when their worker dies unexpectedly 
- (ADP-210) Restoration of legacy wallets from keystore 
- (ADP-211) JavaScript library for parsing cardano-sl's UserSecret 
- (ADP-227) network/information does not work on cardano-node until one creates a wallet
- (ADP-228) Wallet re-syncs from 0% after restarting cardano-wallet-byron
- (ADP-229) CLI support for Byron wallet
- (ADP-230) Cannot send transaction on testnet (cardano-node + cardano-wallet-byron)
- (ADP-189) Coin Selection: Public Specification

### 2020/03/31

- (ADP-191) Recovery phrase verification
- (ADP-211) Random address derivation through the API   
- (ADP-223) Byron wallet CRUD operations (update-name, update-spending password)
- (ADP-231) Restarting cardano-node while cardano-wallet is running breaks cardano-wallet
- (ADP-224) Byron wallet UTXO statistics

### 2020/04/07

- (ADP-97)  Automated nightly syncing tests with Byron TestNet / MainNet
- (ADP-105) Wallet: Client authentication (TLS)
- (ADP-83) Wallet: Local State Query
- (ADP-28) Library/SDK: Address Derivation 
- (ADP-32) Transaction Builder (Payment)

# Week Overview

## :newspaper: Non-Technical Summary

TODO.

## :bug: Bug Fixes

- Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283)
- Network/information does not work on cardano-node until one creates a wallet [#1452](https://github.com/input-output-hk/cardano-wallet/issues/1452)

## :hammer: User Stories

### (ADP-210) Restore Byron wallets from XPrv + Password hash

> As a user of the legacy cardano-sl:wallet,  
> I want Daedalus to be able to automatically restore my existing Byron wallets,  
> So that I don't need to re-enter my recovery phrase   
> And I can enjoy a smooth migration experience to Byron reboot.


```
[=======================================>--------------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-210">More Information</a>
</p>

### (ADP-189) Coin Selection: Public Specification

> As a developer or researcher, I'd like to be able to understand Cardano's
> coin selection and fee balancing algorithms without having to read through
> and understand source code.  Task
> 
> Produce a human-readable specification of the coin selection and fee
> balancing algorithms provided by the cardano-coin-selection library and used
> by cardano-wallet.


```
[==========================>---------------------------------------------------] 50% (1/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-189">More Information</a>
</p>

### (ADP-229) CLI support for Byron wallet

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-229">More Information</a>
</p>


### (ADP-97)  Automated nightly syncing tests with Byron TestNet / MainNet

> We use to have a nightly job running some restoration workers against both
> Byron mainnet and testnet using the http-bridge. These were removed as part of
> input-output-hk/cardano-wallet#634 but were very useful to have a long-running
> test scenarios under "real life" conditions.

```
[------------------------------------------------------------------------------] 0% (0/2)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-97">More Information</a>
</p>

# Known Issues / Debts

- Wallets disappear from list when their worker dies unexpectedly [#1292](https://github.com/input-output-hk/cardano-wallet/issues/1292)
- Wallet restoration extremely slow on Windows [#1398](https://github.com/input-output-hk/cardano-wallet/issues/1398)
- Restarting cardano-node while the wallet is running breaks cardano-wallet [#1468](https://github.com/input-output-hk/cardano-wallet/issues/1468)
- Wallet re-syncs from genesis after restarting cardano-wallet-byron [#1453](https://github.com/input-output-hk/cardano-wallet/issues/1453)
- Cannot send transaction on testnet (cardano-node + cardano-wallet-byron) [#1462](https://github.com/input-output-hk/cardano-wallet/issues/1462)
