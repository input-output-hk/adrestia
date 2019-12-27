# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 52</strong>: 2019/12/23 → 2019/12/27
</p>

# Non-Technical Summary

:information_source: Most of the team was on-leave this week.

Working hard on the 23rd and 24th to deliver a nice Christmas present to our
users with the support of Byron Yoroi wallets into the wallet backend. We've
also spent some time fixing a few minor issues on Windows as well as
investigating how we could allow restoring Hardware device mnemonic into the
wallet backend. This would seemingly move funds from cold to hot storage and
is not really recommended unless users really know what they're doing.

# Overview

## :heavy_check_mark: Completed

- Continued fixing Windows builds in CI and integration tests failures in order to
  fully enable Wine and automated tests on the cross-compiled Windows binary (to avoid
  finding issues at the last minutes like last week...)

- Add support for hardware Ledger auxiliary seed generation method after doing some 
  archeology researches regarding the implementation of some firmware primitives of
  the hardware device. This should effectively allow restoration of Ledger devices
  through the API.

# Bug Fixes

- Fixed unhandled binary error on Windows in the Daedalus IPC connection [#1228](https://github.com/input-output-hk/cardano-wallet/issues/1228)

# User Stories

### :hammer: (WB-46) Byron Hardware Ledger Auxiliary Seed Generation

> **User Story**  
> As an ADA stake holder    
> I want to be able to restore a mnemonic coming from a Byron hardware Ledger wallet,
> so that I can participate in the Jörmungandr TestNet.  

```
[===========================================================>------------------] 75% (0.75/1)
```

> NOTE: Not marking as done yet for we'd like to perform some more testing with real devices.

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
