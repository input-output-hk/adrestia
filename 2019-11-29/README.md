# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 48</strong>: 2019/11/25 → 2019/11/29
</p>

# Non-Technical Summary

~~Winter~~ Delegation is coming! The wallet is now able to delegate its funds
to a stake pool, and it's only one api call away from users. Behind the scene,
the wallet handles the creation and signing of delegation certificates and 
select necessary funds from the user wallet to make it possible. Users can see
how their delegation request is going by monitoring the transaction to which 
it corresponds. Once found in the ledger, delegation certificates are tracked
by the wallet making sure that they also survive chain switches and rollbacks.

We are still in an early phase though and the tracking of rewards is not yet 
finalized. In particular, the reward machinery has only been introduced yesterday
in Jörmungandr `0.8.0-rc1` and we'll finalize the integration next week to make
sure the reward balance is displayed correctly to users!

# Overview

## :heavy_check_mark: Completed

- Extended blocks data-type to carry delegation certificates and, upgraded
  the wallet core model to be able to recognize certificates that are "ours"
  (i.e. using a reward account derived from the wallet root key).

- Added additional tests on the fee policy format plus, cope with necessary
  changes regarding fees in Jörmungandr `0.8.0-rc1`.

- Finalized transaction layer to allow contructing transaction carrying a 
  delegation certificate (for either delegating to one stake pool, or stopping
  delegation altogether). This goes through the usual coin selection from the
  wallet engine to be able to delegate using available UTxOs. 

- Implemented necessary API handlers for joining and quitting a stake pools,
  checking for several possible error paths to avoid users mistake. 

- Extended API **definition** to include stake pool metadata while the 
  corresponding machinery is being implemented. We've made good progress regarding
  fetching a metadata zip archive from a registry web server, parsing it and 
  mapping it their known counterparts. 

- Made sure to only use delegation addresses in the wallet, from the start. This
  allows for making sure a wallet is either fully delegating or not delegating 
  at all. Ideally, for MainNet, we want to allow a more granular control where 
  users may be able to delegate only part of their funds. 

- Upgraded to Jörmungandr `0.7.4`, `0.7.5` and then `0.8.0-rc1`.

## :construction: Underway

- Monitoring wallet reward balance. Most of it is done, but we are finalizing
  integration tests and still trying to make sure that the incentives are enabled
  on our Jörmungandr's node.

- The stake pool metadata registry has been through a couple of last minutes 
  changes so we also need to adapt our parsing code to make sure we can correctly
  get metadata of registered stake pools.

# Bug Fixes

Ø

# User Stories

:information_source: Notice: change in the development process :information_source:

The team is now experimenting with a new refined process regarding task
divisions and story estimation. The goal is be able to gain in productivity and
autonomy by organizing better and, to be able to provide more reliable delivery
dates on estimation. In brief, the changes are as follows:

- The team will now work in 1-week sprints and do weekly releases of the
  product at the beginning of every sprint. Every Monday or Tuesday.
- U/S will no longer be collectively owned, but owned by a single team member.
  The owner, a.k.a the pilot, is seconded by a "co-pilot" challenging them on
  implementation decisions and doing code reviews.
- U/S will no longer be estimated in terms of points, but estimated in terms of
  _number of sprints_. 
- U/S longer estimated for more than 3 sprints will be broken down into smaller
  stories. 



### :heavy_check_mark: Create Delegation Certificates

### :hammer: Monitor Delegated Addresses


> As an API client,
> I am able to obtain a view how many rewards I am earning by taking part to Cardano
> delegation. I am also able to see the amount of actively delegated stake from my 
> wallet and I have access to addresses matching my delegation settings.
> 
> Given that wallet users may have delegation certificates published on the network
> When a delegation certificate is found during restoration
> Then the wallet settings correctly reflect the delegation settings of the last active certificate
> And users are able to monitor their reward balance earned from delegation
> And addresses reflect their delegation settings when listed from the API
> And available and total balance correctly reflects the wallet's activity.

```
[=============================================================================>] 95% (19/20)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/32">More Information</a>
</p>

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
[=======================================>--------------------------------------] 50% (1/2)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/34">More Information</a>
</p>

### :hammer: Estimate cost of delegation

> As an API Client, 
> I want to be able to estimate the cost of joining a stake pool  
> So that I have more details to make a decision before pulling the trigger.  
> 
> Given that I can join a stake pool using a `POST /stake-pools/{stakePoolId}/wallets/{walletId}`  
> When I make a `POST` request to `/stake-pools/{stakePoolId}/wallets/{walletId}/fees`   
> Then I can view estimated fees as part of the response.  

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/36">More Information</a>
</p>

### :hammer: Deal with bootstrapping of the `apparent_performance` for stake pools

> As a stake pool operator    
> I want the pool ordering to be fair and not favor any particular pools especially during the bootstrapping era  
> So that every pool has the same chance to be selected by users in the early stages  
> 
> Given that stake pools can be listed via https://input-output-hk.github.io/cardano-wallet/api/edge/#operation/listStakePools  
> And they are ordered by "apparent performance"  
> When I query stake pools during the first epoch (when little information about them is available)  
> Then pools are ordered arbitrarily  
> And the order is not necessarily the same between different wallets  
> And the order is consistent between successive calls within the same wallet.  

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/38">More Information</a>
</p>

### :hammer: Next epoch available when querying network information

> As an API Client  
> I want to know when and what is going to be next epoch in the network  
> Such that I can display additional informations to end users  
> 
> Given the existing network information endpoint (https://input-output-hk.github.io/cardano-wallet/api/edge/#tag/Network)  
> When I query the network information  
> Then the response is extended with an exta `next_epoch` field giving details about the next epoch.  

```
[------------------------------------------------------------------------------] 0% (0/1)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/35">More Information</a>
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
[------------------------------------------------------------------------------] 0% (0/3)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/37">More Information</a>
</p>




# Known Issues / Debts

- :warning: Haskell.nix updates preventing automatic tests executions under Wine (for Windows) :warning: 
  [#316](https://github.com/input-output-hk/haskell.nix/pull/316) has been merged but we still need some
  work to make sure test under wine are enabled in Hydra at least on nightly builds.

- :warning: Previous Stake Distribution :warning: [#852](https://github.com/input-output-hk/jormungandr/issues/852)
