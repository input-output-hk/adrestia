# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 11</strong>: 2020/03/09 → 2020/03/13
</p>

# Project Overview

## :rocket: Latest release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-03-11](https://github.com/input-output-hk/cardano-wallet/tree/v2020-03-11) | [v0.8.13](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.13)

- (ADP-52) Allow restoration via account public key (for cold storage support)
- (ADP-81) Command-line utilities for key derivation
- (ADP-84) Network clock endpoint for NTP status
- (ADP-92) New JavaScript launcher (no IPC)
- (ADP-94) Extract bech32 library from cardano-wallet
- (ADP-159) Local tx submission integration
- (ADP-193) NTP status via command-line interface

## ⛅ Forecast

### 2020/03/16

- (#1292) Wallets disappear from list when their worker dies unexpectedly 
- (#1442) Unable to retrieve stake-pool list 
- (ADP-192) Restore from public account key in CLI
- (ADP-220) Windows tests failing on Hydra
- (ADP-101) Track stake pool retirements w/ Jörmungandr
- (N/A) Serve cardano-wallet w/ cardano-node on any testnets

### 2020/03/24

- (ADP-210) Restoration of legacy wallets from keystore 
- (ADP-211) Random address derivation through the API   
- (ADP-211) JavaScript library for parsing cardano-sl's UserSecret 

### 2020/03/31

- (ADP-191) Recovery phrase verification
- (ADP-97) Automated nightly syncing tests with Byron TestNet / MainNet

# Week Overview

## :newspaper: Non-Technical Summary

Squashing bugs found on Windows and finalizing our end-to-end integration with
cardano-node. Meanwhile, we are closing the gaps between the new API and the
old one currently used by Daedalus on Mainnet. We are looking for a smooth
transition for both end-users and exchanges while in the same time preserving
the new API of the legacy. This requires some careful considerations regarding
what ought to go in the new API.

In parallel, we also added support for cold wallets, enabling the wallet backend
to work only from an account public key, without ever seeing a private key. This, 
combined with the proxy transaction submission added a while ago enables clients
to build integration with hardware devices such as Legder or Trezor.

## :bug: Bug Fixes

- Still under investigation:
  - Wallet restoration extremely slow on Windows [#1398](https://github.com/input-output-hk/cardano-wallet/issues/1398)

## :hammer: User Stories

### (ADP-192) Restore from public account key in CLI

> As a cardano-wallet API client,  
> I want to be able to restore a sequential wallet from an account public key using the command-line

```
[==============================================================================] 100% (1/1)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-192">More Information</a>
</p>

### NTP status via command-line

> NTP is a protocol to allow time synchronization between remote machines. This
> is particularly essential for Ouroboros is a time-based protocol. In case a
> local clock is drifting too much compared to the global clock, one would want
> to re-sync his clock.  The `network/clock` endpoint was delivered as ADP-84.
> Now we want to have CLI support for it 

```
[==============================================================================] 100% (1/1)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-193">More Information</a>
</p>

### (ADP-210) Restore Byron wallets from XPrv + Password hash

> As a user of the legacy cardano-sl:wallet,  
> I want Daedalus to be able to automatically restore my existing Byron wallets,  
> So that I don't need to re-enter my recovery phrase   
> And I can enjoy a smooth migration experience to Byron reboot.


```
[------------------------------------------------------------------------------] 0% (0/2)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-210">More Information</a>
</p>

# Known Issues / Debts

- Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
- Wallets disappear from list when their worker dies unexpectedly [#1292](https://github.com/input-output-hk/cardano-wallet/issues/1292)
- Wallet restoration extremely slow on Windows [#1398](https://github.com/input-output-hk/cardano-wallet/issues/1398)
- Unable to retrieve stake-pool list [#1442](https://github.com/input-output-hk/cardano-wallet/issues/1442)
