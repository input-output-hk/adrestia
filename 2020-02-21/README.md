# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 08</strong>: 2020/02/17 → 2020/02/21
</p>

# Non-Technical Summary

The team is starting to extract, document and expose in a more developer-friendly 
way various components of its internal architecture. This work takes place as part 
of the _Adrestia_ project (see also: https://github.com/input-output-hk/adrestia/).

Meanwhile, we are upgrading many dependencies  in order to leverage more from the
Haskell eco-system, but also and mainly in order to finalize the integration with
the latest release of `cardano-node`.

# Overview

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-02-17](https://github.com/input-output-hk/cardano-wallet/tree/v2020-02-17) | [v0.8.9](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.9)

## :heavy_check_mark: Completed

- Fixed iohk-nix and Haskell.nix overlays in order to bump Jörmungandr to version 0.8.10+

- Removed local copy of bech32 & bech32-th to fully rely on stackage versions.

- Upgraded API specification from Swagger 2.0 to Swagger 3.0.0. 

- Added command-line command for extracting root private keys from mnemonic sentences.

- Allowed creating wallets from an account public key (instead of a mnemonic). 

- Created Adrestia repository and documented Adrestia approach and architecture (https://github.com/input-output-hk/adrestia/)

- Bumped Stack LTS and cardano-node's dependencies to support cardano-node's stack version 1.5.


# Bug Fixes

- Latency benchmark failing #1356

# User Stories

### :heavy_check_mark: (ADP-159) Local Tx Submission Integration

### :hammer: (ADP-81) Wallet: Command-line utils for key derivation

> **User Story**  
> As a wallet CLI,
> I am able to do HD derivation
> so that I am able create keys from a mnemonic.

```
[=====================================================>------------------------] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-81">More Information</a>
</p>


### :hammer: (ADP-37) Library/SDK: Coin Selection & Fee Balancing

> As a Cardano developer,  
> I am able to use pre-defined coin selection and fee balancing algorithms,  
> So that I can leverage existing work easily.   

```
[------------------------------------------------------------------------------] 0% (0/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-37">More Information</a>
</p>


# Known Issues / Debts

-  Windows tests are failing on hydra [#1283](https://github.com/input-output-hk/cardano-wallet/issues/1283) 
