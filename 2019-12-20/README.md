# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 51</strong>: 2019/12/16 → 2019/12/20
</p>

# Non-Technical Summary

Last week release shed some lights on issues that were hard to capture in a
local testing environment. So, we've mostly been working on bug fixing this 
week in order to deliver a better experience and more stable wallets to users
of the incentivized testnet.
Meanwhile, we've also added support for Byron Yoroi wallets working around some
of the caveats the incentivized testnet snapshot causes.

# Overview

## :heavy_check_mark: Completed

- Support Byron Yoroi wallets through the Byron API endpoints. This is a rather transparent
  change for API clients who can now use the same API to manipulate Byron Yoroi wallets after
  restoring a 15-word mnemonic sentence. Behind the scene, it illustrates some of the power 
  of the wallet engine which is now a single codebase used with variety of wallets schemes:

  - Random derivation on Byron addresses
  - Sequential derivation on Byron addresses 
  - Sequential derivation on Jörmungandr addresses

- Completed a gap analysis between Jörmungandr <-> Haskell nodes, primarily focused on Byron
  nodes. We haven't found any major blockers as most areas of disprecency where already 
  identified in the now dead http-bridge implementation. 

- Upgraded to Jörmungandr `0.8.3` -> `0.8.4` -> `0.8.5-alpha1` -> `0.8.5`

# Bug Fixes

- Fixed rollback issues in the stake pool worker [#1200](https://github.com/input-output-hk/cardano-wallet/issues/1200).
- Fixed flaky integration tests wrongly using network's epoch instead of node's epoch [#1196](https://github.com/input-output-hk/cardano-wallet/issues/1196)
- Fixed chain active slot coefficient not taken into consideration when computing sync progress [#1197](https://github.com/input-output-hk/cardano-wallet/issues/1197)
- Fixed chain active slot coefficient ignored in performance calculation [#1188](https://github.com/input-output-hk/cardano-wallet/issues/1188)
- Fixed misleading error message when providing an invalid mnemonic sentence [#1153](https://github.com/input-output-hk/cardano-wallet/issues/1153)
- Fixed wallet not deleted properly leading to a corrupted sqlite file [#1071](https://github.com/input-output-hk/cardano-wallet/issues/1071)
- Investigated "Possible missing db migration between balance-check version and latest one" [#1177](https://github.com/input-output-hk/cardano-wallet/issues/1177)
  - We're currently working on a set of automated nightly tests to test migrations of wallets 
    using `k` latest versions. Ideally, we should test all possible migration paths from any
    previous releases. 
- Investigated "Zero balance reported on the wallet despite receiving funds from faucet" [#1146](https://github.com/input-output-hk/cardano-wallet/issues/1146)
  - So far, most cases seemed to be a combination of chain switches and a poor
    network connection resulting in the wallet not catching up with the network
    in a timely manner. We've also revised logs in this area and the way database
    transactions were organized ... just-in-case.

# User Stories

### :heavy_check_mark: (WB-26) Haskell cardano-node gap analysis
### :heavy_check_mark: (WB-27) Support Byron Yoroi Wallets 

### :hammer: (WB-46) Byron Hardware Ledger Auxiliary Seed Generation

> **User Story**
> As an ADA stake holder  
> I want to be able to restore a mnemonic coming from a Byron hardware Ledger wallet,
> so that I can participate in the Jörmungandr TestNet.  

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/43">More Information</a>
</p>

### :hammer: (WB-48) Order stake pool by "desirability"

> **User Story**
> As a wallet user,
> I can delegate to top ranked stake pools,
> so that I can easily stake with confidence.

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/44">More Information</a>
</p>


# Known Issues / Debts

- :warning: Still working on enabling automated test execution under Wine. :warning: 
  Outstanding issues are captured in [#1115](https://github.com/input-output-hk/jormungandr/issues/1115)

- :warning: Previous Stake Distribution :warning: [#852](https://github.com/input-output-hk/jormungandr/issues/852)
