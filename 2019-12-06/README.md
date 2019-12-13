# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 49</strong>: 2019/12/02 → 2019/12/06
</p>

# Non-Technical Summary

Rewards finally landed into cardano-wallet! Next to the wallet available
balance and total balance is now reported the wallet reward balance, magically
increasing when delegating ADA to a productive pool leader.

Meanwhile, we have added a special "reward-credentials" command to the
command-line to enable pool operators to also use cardano-wallet (and by
extension Daedalus) to track their own rewards and setup their stake pool using
their existing wallet. Step-by-step guides are now available on the Cardano
Foundation pool registry wiki (https://github.com/cardano-foundation/incentivized-testnet-stakepool-registry/wiki).

# Overview

## :heavy_check_mark: Completed

- Aligned stake pool registry implementation and data-types with the new metadata
  decided for the registry. 

- Fetch and display reward account balance alongside other balances (total and available).
  This was quite cumbersome and late in the end because only got available in Jörmungandr 0.8.0-rc7.
  But finally, we are now able to delegate and see rewards flowing through wallets.

- Implemented on-chain binary deserializer for stake pool registration. Since the metadata
  registry has switched focus from "stake pools" to "pool owners", the wallet backend now
  requires to keep track of a many-to-many relationship between owners and pools and 
  reconciliate which owner owns which pool.

- Fixed some issues with Haskell `zip` library preventing it from cross-compiling with Haskell.nix.
  The library used to require a system library (`bzlib2`) which has now be made optional behind a 
  flag.

- Fixed failures in Benchmark due to invalid data being generated. We recently enforced stricter 
  types on some of our core wallet types and the benchmark generator were slightly off.

- Made sure to arbitrarily shuffle the list of stake pools returned by the API during the first
  epoch. This is in order to not favor any particular stake pools more than others when there's not
  a sufficient amount of data to build a reliable ranking. The order is "stable" for a same wallet
  server, but different across servers. 

- Fixed some paths references causing issues in integration tests on Windows only.

- Added an extra `next_epoch` to the API network information to allow client like Daedalus to 
  display countdowns and other details for delegation.

- Adjusted a few API responses and documentations details.

- Add endpoint to estimate fees for joining/quitting a stake pools, for a better user experience
  in clients.

- Revised and finalized the stake pool metadata registry validator, aiming for a smooth experience
  for pool operators. 

- Extended the wallet command-line with a special command `mnemonic reward-credentials` to allow 
  deriving a wallet's assigned reward account from its root mnemonic. This allows for an easy interop
  with `jcli` to create a stake pool registration certificate using that account and, monitoring 
  corresponding rewards directly in Daedalus or Yoroi.

- Wrote detailed step-by-step guides on how to use `cardano-wallet`, `jcli` and `jormungandr` to register
  stake pools and submit metadata to the registry. More details here: https://github.com/cardano-foundation/incentivized-testnet-stakepool-registry/wiki
  Already 23 PRs from the community and operators who wants to register their metadata :tada: !

- Upgraded to Jörmungandr `0.8.0-rc1`, `0.8.0-rc4`, `0.8.0-rc5`, `0.8.0-rc6`, `0.8.0-rc7` and finally `0.8.0-rc8`

## :construction: Underway

- Wiring up metadata fom the registry with stake pools registrations found on chain.

- More fixes for the nix pipeline and the automated wine tests for Windows

- Upgrade to Jörmungandr `0.8.0-rc9`

- Measure latencies on a few critical API endpoints to identify potential area of optimizations
  and bottlenecks on the server.

# Bug Fixes

- Benchmark is failing and timing out [#1067](https://github.com/input-output-hk/cardano-wallet/issues/1067)

# User Stories

### :heavy_check_mark: Create Delegation Certificates

### :heavy_check_mark: Monitor Delegated Addresses

### :heavy_check_mark: Estimate cost of delegation

### :heavy_check_mark: Deal with bootstrapping of the `apparent_performance` for stake pools

### :heavy_check_mark: Next epoch available when querying network information

### :hammer: Collect stake pool metadata

> As a API client,  
> I can list available stake pools,  
> so that I am able to view the corresponding metadata when available.  
> 
> Given that metadata for registered stake pools are available in https://github.com/cardano-foundation/incentivized-testnet-stakepool-registry  
> And are stored in a "registry" folder as JSON objects matching the JSON meta-schema given in annex below  
> When I fetch all available metadata using a zip archive https://github.com/cardano-foundation/incentivized-testnet-stakepool-registry/archive/master.zip  
> Then I can associate corresponding metadata to known stake pools  
> And I can extend the response of `listStakePools` with a `metadata` matching those from the registry (minus the `id`)  
> And I can leave `null` metadata of known stake pools that aren't present in the registry.  

```
[====================================================>-------------------------] 66% (2/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/34">More Information</a>
</p>

### :hammer: API Latency

> As a Developer of the Wallet backend,  
> I can measure latency of GET endpoints of the API  
> So that I can produce reports helping making decisions about areas that need optimization.  
> 
> Given that I can automatically setup a benchmarkable server with realistic wallets  
> And that this setup can be ran on nightly builds  
> When I exercise endpoints of the API via well-formed http requests  
> Then I can get precise measures of latency for these endpoints  
> And I am able to produce a human-readable report with these results.   

```
[=======================================>--------------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/37">More Information</a>
</p>


# Known Issues / Debts

- :warning: Still working on enabling automated test execution under Wine. :warning: 
  Outstanding issues are captured in [#1115](https://github.com/input-output-hk/jormungandr/issues/1115)

- :warning: Previous Stake Distribution :warning: [#852](https://github.com/input-output-hk/jormungandr/issues/852)
