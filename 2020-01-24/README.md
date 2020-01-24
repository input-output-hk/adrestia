# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 04</strong>: 2020/01/20 → 2020/01/24
</p>

# Non-Technical Summary

# Overview

The wallet backend now computes new metrics about stake pools: desirability and
saturation. These should help users to decide to which stake pools they should
be delegating to achieve full decentralization. On the side, we've been
resolving several issues regarding our database and migrations from previous
versions, especially when it comes to catching issues before they reach
end-users!

Meanwhile, we've reached a big milestone this week by finally connecting the
re-written Haskell nodes with the wallet backend, restoring actual MainNet
wallets using the very same API the backend provides on the incentivized
TestNet. We are also putting effort in a new launcher to bring this down to
Daedalus as well. Once complete, this would mark the end of the 'cardano-sl' 
era and the beginning of the new Haskell nodes era! 

## Latest Release

cardano-wallet                                                                    | jormungandr compat
---                                                                               | ---
[v2020-01-14](https://github.com/input-output-hk/cardano-wallet/tree/v2020-01-14) | [v0.8.5](https://github.com/input-output-hk/jormungandr/releases/tag/v0.8.5)

## :heavy_check_mark: Completed

- Added a few extra integration tests regarding the new per-component logging.

- Added nightly database migration tests to our continuous integration pipeline.
  This effectively attempts to run the latest version of `cardano-wallet` from various
  past releases in order to catch potential issues with the database. Over the past 
  months, we've encountered various migration issues with the database. This nightly
  test should now help us catch these issues much earlier in the development.

- Continued house-keeping in the integration test scenario.

- Revised calculation of the apparent performance to favor less lucky pools and be less
  punitive on unlucky ones. 

- Added some extra documentation for the per-component logging option directly in the 
  command-line

- Now sort stake-pools by desirability according to the incentive and delegation paper.
  The calculation of the apparent performance is however still relatively unreliable
  due to the lack of access to historical data on the node (regarding the stake distribution).
  This makes the ranking skewed to what a particular knows about the past and therefore, 
  makes the whole ranking look a bit clunky. 

- Drafted a new API endpoint to allow clients to fetch blockchain parameters (epoch length,
  transaction max size etc ...) directly from the API.

- First integration between `cardano-wallet` and `cardano-node` (using the byron-proxy). 
  We've been able to restore a MainNet wallet via the wallet API with full access to its
  transaction history, UTxO and balances. Making transactions from such wallets is not yet
  possible but coming soon.

- Upgraded to Jörmungandr 0.8.7.

# Bug Fixes

- Attempted to fix #1279 (`persistent` clear foreign tables on automatic
  migration due to cascading delete) without success.  The initial approach
  works for most wallet but doesn't for wallets that require accessing genesis
  UTxO in the genesis block (like all legacy wallets on the incentivized
  testnet). Users can current work around this by manually deleting and restoring
  their legacy wallets but this is a really unsatisfactory user experience.
  Fixing this properly demands us to roll our own migration mechanism and move
  away from the automated one provided by `persistent`.

- Cannot list wallets when using same state directory but different genesis #1292 

- Rolling back stake pools take ages [#1281](https://github.com/input-output-hk/cardano-wallet/issues/1281)

# User Stories

### :heavy_check_mark: (WB-48) Order stake pool by "desirability"

### :heavy_check_mark: (WB-53) Integrate cardano-wallet with Haskell Byron-rewrite

### :heavy_check_mark: (WB-??) Clean up integration tests

### :hammer: (WB-47) Expose blockchain parameters via new endpoint

> **User Story**  
> As an API client,  
> I can get blockchain parameters for various epochs,  
> And I can get blockchain parameters for the latest epoch,  
> So that I can build better interfaces based on these parameters.  

```
[=======================================>--------------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/51">More Information</a>
</p>

### :hammer: (ADP-92) Launcher: New launcher (no updates)

> **User Story**  
> 1. I want to start cardano-wallet (and its node)  
> 2. I want to cardano-wallet to use a free TCP port for its server  
> 3. I want to receive events when the wallet backend is started/stopped  
> 4. I want to receive events when the node is started/stopped  
> 5. I want to receive an event when the wallet API is ready  
> 6. I want a method to get the wallet backend API base URL and connection parameters  
> 7. I want a method to cleanly and reliably stop cardano-wallet (and its node)  
> 8. I want a documented Javascript module with typed interface files  
> 9. I want the cardano-launcher to be well-tested on Windows  
> 10. I want the module to output detailed logging  

```
[=========================>----------------------------------------------------] 33% (1/3)
```

<p align="right">
  <a target="_blank" href="https://jira.iohk.io/browse/ADP-92">More Information</a>
</p>

# Known Issues / Debts

- `persistent` clear foreign tables on automatic migration due to cascading delete [#1279](https://github.com/input-output-hk/cardano-wallet/issues/1279)
-  Windows tests are failing on hydra #1283 
