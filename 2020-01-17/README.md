# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 03</strong>: 2020/01/13 → 2020/01/17
</p>

# Non-Technical Summary

# Overview

While working on better statistics and ranking for stake pools, we've also
spent some time in performing an internal audit of the wallet API according to
well-known best practices. Least we can say is that the wallet API is doing
fairly good and, possible points of improvement are already in preparation in
the backlog! This week was also about stability, working hard to get the system
in a very stable and resilient state for the upcoming release of Daedalus. 

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-01-14](https://github.com/input-output-hk/cardano-wallet/tree/v2020-01-14) | [v0.8.5](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.5)

## :heavy_check_mark: Completed

- Calculate stake pool desirability according to the incentive and delegation design specs.

- Revise apparent performance calculation to be less punitive for pools at the beginning of 
  an epoch and somewhat better reflect actual pools' performance. 

- New endpoint to allow the wallet tip to be replaced at a prior point in time. 
  This can come in handy to force the wallet to re-sync in extreme cases where
  something went wrong with the restoration. This improves the user experience 
  as users can query the API directly instead of manually removing their on-disk
  database files. 

- More cleaned up in integration tests, not there yet but, progressing.

- Analyzed API best practices according to top-10 list of security and best practices
  guidelines from OWASP. The goal was to conduct an internal audit of our API to 
  identify potential flaws or risk. Conclusions:

  - Our database implementation is resistant from direct SQL injection.
  - Every endpoint is well documented and perfectly up-to-date with their actual JSON representation.
  - The Server behaves well when presented with incompatible headers, in particular about content-types.
  - No sensitive information appears in log, including at the debug level. 
  - Logging happens to the standard output which makes it easier to manage for operations. 
    Logging to files with file-rotation support can easily be enabled via configuration.
  - :warning: All communication still happens unencrypted and unauthenticated (no TLS). 
    A story about API authentication is however present in the product backlog.
  - :warning: No API rate-limiter. Could be a potential issue although the API is not public facing 
    and typically has only a single client (e.g. Daedalus). 

- A second pass on logging per-component to also add the wallet engine as a component. Also did some 
  revision regarding other components to make the overall interface more uniform and consistent.

# Bug Fixes

- Missing database migration for `active_slot_coeff` when migrating from v2019-12-13 and prior [#1251](https://github.com/input-output-hk/cardano-wallet/issues/1251)

- "Something went wrong" when listing stake pools from inside a Docker container [#1256](https://github.com/input-output-hk/cardano-wallet/issues/1256)

- Failing tests integration tests on Windows [#1115](https://github.com/input-output-hk/cardano-wallet/issues/1115)

- (Some) logs of severity "DEBUG" shows up as "INFO" [#1273](https://github.com/input-output-hk/cardano-wallet/issues/1273)

# User Stories

### :heavy_check_mark: (WB-14) Review API best practices about security

### :hammer: (WB-48) Order stake pool by "desirability"

> **User Story**  
> As a wallet user,  
> I can delegate to top ranked stake pools,  
> so that I can easily stake with confidence.

```
[==========================================================================>---] 90% (1/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/44">More Information</a>
</p>

### :hammer: (WB-53) Integrate cardano-wallet with Haskell Byron-rewrite

> **User Story**    
> As a cardano-wallet developer,  
> I want to be able to start a version of the cardano-wallet against a running Haskell Byron node.


```
[==========================>---------------------------------------------------] 33% (1/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/49">More Information</a>
</p>

### :hammer: (WB-??) Clean up integration tests

> **User Story**    
> As a cardano-wallet developer,  
> I want a clean, maintainable and non error-prone integration environment  
> so that I can write test scenarios faster and with confidence.

```
[=====================================================>------------------------] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/45">More Information</a>
</p>

# Known Issues / Debts

- Rolling back stake pools take ages [#1281](https://github.com/input-output-hk/cardano-wallet/issues/1281)
- `persistent` clear foreign tables on automatic migration due to cascading delete [#1279](https://github.com/input-output-hk/cardano-wallet/issues/1279)
