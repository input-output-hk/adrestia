# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 01</strong>: 2019/12/30 → 2020/01/03
</p>

# Non-Technical Summary

:information_source: Most of the team was on-leave this week.

Priority this week was on finalizing the API and testing of the hardware
wallets restoration, working closely with Daedalus to also give them the
ability to test thoroughly the integration as well. 

In the meantime, we are leveraging the calm coming with the new year to make
some rather intrusive changes in the wallet implementation. Hence we are
restructuring logs to gain more control and granularity to eventually get more
debugging power when problems arise. 

# Overview

## :heavy_check_mark: Completed

- Finalized testing and API for hardware wallets restoration. We have introduced some
  agreed upon breaking changes in the API to simplify the restoration of legacy wallets. 
  The result is a well-segmented and documented interface with dedicated endpoints and 
  descriptions to make it crystal clear for API users.

  See also https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/postByronRandomWallet

# Bug Fixes

- Still investigating the incoherent balances reported by some users under
  bad network conditions. We now have identified a potential cause of the 
  problem and are working on a fix. See also: [#1146](https://github.com/input-output-hk/cardano-wallet/issues/1146)

- Fixed CI automated check (weeder) not working properly after upgrade to stack 2+ [#1219](https://github.com/input-output-hk/cardano-wallet/pull/1219)

- Working on turning on storage to disk in some integration tests (instead of
  using the in-memory version of SQLite) to get closer to the production
  environment with the hope of catching more issues early on.

# User Stories

### :heavy_check_mark: (WB-46) Byron Hardware Ledger Auxiliary Seed Generation

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

### :hammer: (WB-31) Allow logs to be filtered by components

> **User Story**  
> As a technical user using the command-line  
> I want to be able to increase or decrease logging verbosity of specific components of the wallet server  
> So that I can debug more easily issues with the software   

```
[========================================>-------------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/46">More Information</a>
</p>


### :hammer: (WB-??) Minimal `cardano-wallet` integrated with Haskell Byron Node

# Known Issues / Debts

- :warning: Still working on enabling automated test execution under Wine. :warning: 
  Outstanding issues are captured in [#1115](https://github.com/input-output-hk/jormungandr/issues/1115)
