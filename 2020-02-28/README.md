# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 09</strong>: 2020/02/24 → 2020/02/28
</p>

# Non-Technical Summary

Continued working on the new cardano-launcher as well as a testing setup for
cardano-node.  We've taken some time this week to upgrade quite a few
dependencies, libraries and standards used across many components of
cardano-wallet.

Meanwhile, the wallet command-line now provides tools for manipulating wallet
credentials and do operations such as mnemonic to root private key generation,
or parent to child key derivation.  This is particularly handy for devops and
pool operators who need to actively manage their credentials.

A few issues regarding Windows are also under investigation.

# Overview

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-02-17](https://github.com/input-output-hk/cardano-wallet/tree/v2020-02-17) | [v0.8.9](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.9)

## :heavy_check_mark: Completed

- Added shutdown handler for the new launcher ([cardano-launcher](https://github.com/input-output-hk/cardano-launcher)).

- Added CLI command for extracting root private key from mnemonics, as well as a few derivation functions
  for doing HD derivation (root key to children, private to public, key inspection...).

- Bumped stack LTS to a more recent version, in order to bump cardano-node to 1.6.0. 

- Extended wallet creation to allow restoring from an account public key only.

- Updated API specification (swagger) to OpenAPI 3.0 

- Upgraded integration to Jörmungandr 0.8.12, and then 0.8.13

- Better error reporting for integration scenarios waiting for an action to eventually happen.

- Improved delegation logging, including better overview for pending delegation

# Bug Fixes

- Ø

# User Stories

### :heavy_check_mark: (ADP-141) Multiple next's support in delegation reporting
### :heavy_check_mark: (ADP-92) Launcher: New launcher (no updates)
### :heavy_check_mark: (ADP-52) Hardware Wallet: Restore Sequential Wallet From Public Key
### :heavy_check_mark: (ADP-81) Wallet: Command-line utils for key derivation


### :hammer: (ADP-37) Library/SDK: Coin Selection & Fee Balancing

> As a Cardano developer,  
> I am able to use pre-defined coin selection and fee balancing algorithms,  
> So that I can leverage existing work easily.   

```
[=========================>----------------------------------------------------] 33% (1/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-37">More Information</a>
</p>

### :hammer: (ADP-84) Network clock endpoint for NTP status

> NTP is a protocol to allow time synchronization between remote machines. This
> is particularly essential for Ouroboros is a time-based protocol. In case a
> local clock is drifting too much compared to the global clock, one would want
> to re-sync his clock.

```
[=======================================>--------------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-84">More Information</a>
</p>

# Known Issues / Debts

- Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
- 0.5% profit margin of pool is rounded to 0% [#1331](https://github.com/input-output-hk/cardano-wallet/issues/1331)
- Wallets disappear from list when their worker dies unexpectedly [#1292](https://github.com/input-output-hk/cardano-wallet/issues/1292)
- Wallet restoration extremely slow on Windows [#1398](https://github.com/input-output-hk/cardano-wallet/issues/1398)
