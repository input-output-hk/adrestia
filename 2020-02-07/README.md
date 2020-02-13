# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 06</strong>: 2020/02/03 → 2020/02/07
</p>

# Non-Technical Summary

A week dedicated to housekeeping mostly and bug fixing a staggering issue
that has been noticed for quite a while but for which we failed to find a
proper fix, until now. Meanwhile, we've also worked on improving the reporting
on delegation statuses of wallets. Delegation changes abide by a grace period 
of one epoch; said differently, a wallet's delegation statuses only change the
next epoch following the epoch the certificate was inserted into the ledger. 
This is now correctly capture by the wallet and should enable Daedalus to build
an awesome UX on top of it (as usual)!

# Overview

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-01-27](https://github.com/input-output-hk/cardano-wallet/tree/v2020-01-27) | [v0.8.7](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.7)

## :heavy_check_mark: Completed

- Improve delegation reporting, now showing "pending" delegation certificates 
  about to take effect. This allows ultimately for a better UX in frontend clients
  like Daedalus.

- Housekeeping on the `bech32` library and finally, use our published copy on Hackage
  instead of the local one.

- Add command-line support for fetching network parameters of any given epoch.

- Further housekeeping in the integration scenarios

# Bug Fixes

- `persistent` clear foreign tables on automatic migration due to cascading delete [#1279](https://github.com/input-output-hk/cardano-wallet/issues/1279)

# User Stories

### :heavy_check_mark: (ADP-92) Launcher: New launcher (no updates)

### :heavy_check_mark: (ADP-94) Bech32 Library Extraction

### :hammer: (ADP-81) Wallet: Command-line utils for key derivation

> **User Story**  
> As a wallet CLI,
> I am able to do HD derivation
> so that I am able create keys from a mnemonic.

```
[======================================================>-----------------------] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-81">More Information</a>
</p>

### :hammer: (ADP-111) Better reporting of delays in delegation status

> **User Story**  
> As a wallet client,
> I want to reliably know how my delegation changes,
> So that I can better inform users about their current and next delegation settings.

```
[===========================================>----------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-111">More Information</a>
</p>


### :hammer: (ADP-159) Local Tx Submission Integration

> We've integrated with the chain-sync mini-protocol on a Byron rewritten node
> but are still using a placeholder for transaction submission. Transaction
> submission needs to be allowed through the API for the Byron-rewritten
> integration.

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-159">More Information</a>
</p>


# Known Issues / Debts

-  Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
