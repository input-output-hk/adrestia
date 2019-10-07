# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 40</strong>: 2019/09/30 → 2019/09/04
</p>

# Non-Technical Summary

We are now working on three fronts in parallel: Byron wallets support, stake pool tracking,
and chain following in a decentralized network where forks may happen arbitrarily. The last
two are getting to an end and getting most of our attention in terms of testing. We've reworked
our networking layer to capture the fact that nodes may switch to different chains as they see
fit. This was done in such a way that we are able to implement this logic for Jörmungandr, while
leaving our overall interface sufficiently flexible to allow implementing it using a different
networking interface like the Haskell cardano-node uses. We are now also collecting data about
stake pools, and returning a list of existing stake pools with the number of blocks they are
producing. In a next iteration, we'll introduce some performance metric for each of them to
effectively allow clients to list and order stake pools according to how well they perform.

# Overview

## :heavy_check_mark: Completed

- Completed first in-memory implementation of stake pool tracking. The chain following
  has been pulled out of the wallet engine and made slightly more abstract so that we 
  could re-use it to monitor stake pools production. The API for listing stake pools
  has also been implemented as well as the corresponding command in the command-line. 
  We're now making sure that data gets persisted between restarts such that the server
  doesn't have to go through the whole chain on each restart. Doing that, we've also
  reworked the chain following logic to make it more resilient to exceptions, introducing
  fail overs and retry mechanisms allowing the wallet to recover (and log) network failures 
  or component failures.

- Defined API types and interface to provide support for legacy wallets. Handlers are 
  a straightforward composition of primitive blocks we have already defined and will be
  implemented shortly after.

- We've finalized fork detection in the networking layer as well as rollback support and
  are wrapping up testing in this area. We've defined a (simple) mock Jörmungandr node to 
  emulate block production and forks and are verifying that chain following works as expected.

- Continued QA of checkpoint management for rollbacks support. We discovered a few 
  interesting bug and performance issues that has been fixed:

  - We have removed some of the database logic regarding clean up and deletion and 
    instead, moved that as database constraints in order to leverage cascading from
    the database itself. 

  - We are now creating sparse checkpoints instead of contiguous big chunks, basically
    cutting the database's size by a 100. Creating sparse checkpoint is tricky in Ouroboros
    Praos because we know small chain forks might occur and therefore, it is often 
    needed to rollback for a few blocks only. So, our checkpoints management now
    maintains dense checkpoints near the network tip, and sparse ones for the rest 
    of the chain. For a constant `k=2160`, we can therefore reduce the number of checkpoints
    to 30 instead of 2160 and get pretty similar performances. 

  - We've have strengthen our data-type generation in the database property and 
    state-machine testing to cover a wider range of values, triggering more interesting
    test cases and catching more issues.

  - Reviewed our database benchmarks and fixed some issues due to non-strict evaluation of
    long data-structure. We also introduced a new bench for analyzing reading transaction 
    history from the database. Database benchmarks are now covering and providing metrics for:
    
      - Checkpoint (including UTxO) Read & Write
      - Transaction history Read & Write
      - Address Discovery State Read & Write

## :construction: Underway

- Storing stake pools metrics to the database

- Integration tests for Byron wallets support

- Implementing restoration & migration of Byron wallets

- More testing on the fork detection and rollback logic


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
[=====================================================================>-------]  88% (35/40)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/25">More Information</a>
</p>

### :hammer: Listing Registered Stake Pools

> Clients interested in delegating need to know from a trusted source what are
> the available stake pools. Ideally, clients want the ability to sort existing
> stake pools according to a particular metric. 

```
[=================================================>----------------------------]  63% (13/21)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/28">More Information</a>
</p>


### :hammer: Byron Wallet Support

> This milestone will add support for legacy Byron wallets. Users will be able
> to: restore a legacy wallet; view the balance of a legacy wallet; calculate the
> cost of migrating to a new wallet; and migrate funds from a legacy wallet to a
> new wallet. 

```
[================>-------------------------------------------------------------]  22%
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/29">More Information</a>
</p>


# Known Issues / Debts

- :warning: We still can't run the wallet (or any of the tests) on **Windows** nor
  **OSX**. The cross-compilation builds need to be fixed or, we need to consider 
  building from Windows and OSX machines. This is becoming URGENT.
