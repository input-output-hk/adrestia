# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 39</strong>: 2019/09/23 → 2019/09/27
</p>

# Non-Technical Summary

# Overview

## :heavy_check_mark: Completed

- Extracted block height from binary blocks instead of computing it.

- Extended properties and state-machine testing to cover rollbacks. 
  This achieves to test the database layer and the introduction 
  of rollbacks. Now remains some performance improvements to be 
  taken care of.

- Reviewed database schema regarding storage of address discovery
  state; removing some unnecessary indirection and simplifying 
  management of states in the case of rollbacks.

- Made the network layer polymorphic over blocks. Allowing to effectively 
  run two networking layers side-by-side using different representations
  for blocks. This will allow us to implement a chain follower to watch
  the chain looking for stake pool certificates, building statistics about
  stake-pools.

- Moved tracking of pending transactions outside of the wallet model; turned
  out that keeping track of it in this place created a lot of indirections and
  implications. It forced us to maintain two sources of truth which is a 
  great risk for internal inconsistency. 

- Reviewed and design API interface for listing stake pools. Implementation
  is coming along.

- Upgraded to Jörmungandr `0.5.2`

- Added benchmark for read operation on UTxO; this allowed us to 
  evaluate and review our strategy regarding the storage of checkpoints.
  
- Small improvements in tests scenarios, reducing duplication and reviewing
  file organization.

## :construction: Underway

- Reworking process management and resources allocations, moving starting
  up the underlying chain producer down to the networking layer for better
  control.

- Wire up rollbacks in the networking layer; database is now ready to support 
  rollback and the network layer already keeps track of unstable blocks (where
  rollbacks might occur) but we now have to identify when a rollback occurs, 
  find an intersection point to rollback to between the node and our local chain.

- Maintain a list of registered stake pools and keep track of the number of
  blocks produced by stake pools for each epoch.

# User Stories

### :hammer: Support Rollbacks

> In a standard setup, it is very likely for a core node to roll-back (i.e.
> rewind the chain to a previous point in time). This means that the wallet
> backend must be able to correctly keep track of blocks, rolling backwards
> when needed and not only append blocks to an existing chain. Doing so,
> transactions that could have been inserted in recent blocks might become
> pending again, and balances may change to reflect the chain after a rollback.
> Beside, we do not want roll back to have a significant impact on the software
> usability. Hence, most features should remain available during rollbacks.
> Submitting transactions may be however forbidden during rollbacks.

```
[=========================================================>-------------------]  75% (30/40)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/25">More Information</a>
</p>

### :hammer: Listing Registered Stake Pools

> Clients interested in delegating need to know from a trusted source what are
> the available stake pools. Ideally, clients want the ability to sort existing
> stake pools according to a particular metric. 

```
[=========>-------------------------------------------------------------------]  10% (2/21)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/28">More Information</a>
</p>


# Known Issues / Debts

- N/A
