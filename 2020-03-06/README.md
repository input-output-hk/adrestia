# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 10</strong>: 2020/03/02 → 2020/03/06
</p>

# Non-Technical Summary

First e2e integration scenarios of sending a transaction from a Byron wallet to
another Byron wallet using a combination of `cardano-wallet` and
`cardano-node`! This is a major milestone we hope to release next week after a few
more integration scenarios have been controlled.

We are also investigating a few issues recently discovered and in particular, some
odd behaviors noticed on Windows machines. We are also close to be able to run automated
nightly tests on a Windows environment which should help catching these issues much
faster! 

# Overview

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-02-17](https://github.com/input-output-hk/cardano-wallet/tree/v2020-02-17) | [v0.8.9](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.9)

## :heavy_check_mark: Completed

- Added foundation for integration testing on a private OBFT blockchain running
  via `cardano-node`. We have successfully replayed most of our relevant
  integration scenarios from Jörmungandr.

- Implemented new endpoints to allow making transaction and estimating payment fees
  from Byron wallets. First integration tests are passing :tada:. 

- Fixed thread synchronization issue within the integration framework causing the 
  underlying node process to sometimes stay alive after the tests have ran. 

- New endpoint for checking local clock offset compared to a central NTP server. 

- Additional tests for the "hardware wallets" endpoints (wallets created from account public keys).

- Fixed nightly database migration tests failing after latest bump of Haskell.nix.

- Fixed Nix build caching not working properly after latest bump of Haskell.nix.

- Revised and adjusted manual tests procedures.


# Bug Fixes

- 0.5% profit margin of pool is rounded to 0% [#1331](https://github.com/input-output-hk/cardano-wallet/issues/1331)

- Still under investigation:
  - Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
  - Wallets disappear from list when their worker dies unexpectedly [#1292](https://github.com/input-output-hk/cardano-wallet/issues/1292)
  - Wallet restoration extremely slow on Windows [#1398](https://github.com/input-output-hk/cardano-wallet/issues/1398)

# User Stories

### :heavy_check_mark: (ADP-84) Network clock endpoint for NTP status

### :hammer: (ADP-37) Library/SDK: Coin Selection & Fee Balancing

> As a Cardano developer,  
> I am able to use pre-defined coin selection and fee balancing algorithms,  
> So that I can leverage existing work easily.   

```
[===================================================>--------------------------] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-37">More Information</a>
</p>

### :hammer: (ADP-159) Local Tx Submission Integration

> Integration tests with a local OBFT cardano-node

```
[==============================================================================] 100% (2/2)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-159">More Information</a>
</p>


# Known Issues / Debts

- Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
- Wallets disappear from list when their worker dies unexpectedly [#1292](https://github.com/input-output-hk/cardano-wallet/issues/1292)
- Wallet restoration extremely slow on Windows [#1398](https://github.com/input-output-hk/cardano-wallet/issues/1398)
