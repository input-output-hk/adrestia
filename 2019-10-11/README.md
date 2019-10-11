# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 41</strong>: 2019/10/07 → 2019/10/11
</p>

# Non-Technical Summary

Intensive week with progresses on many fronts. The team efforts in testing rollbacks
and chain following have finally paid off. While part of the team was busy with making
sure the wallet would work fine in a decentralized setup where nodes may switches to 
different chains arbitrarily, an other part of the team has been focusing on getting 
data about stake pools stored in a database and served through an HTTP interface. This
will enable frontend clients like Daedalus to give insights about available stake pools
and how they perform. 
We are also continuing our efforts to introduce a backward compatible API to effectively
allow current users of Daedalus to migrate their wallet into the new format now supported
by the backend (which is seemingly the same one used by Yoroi).

# Overview

## :heavy_check_mark: Completed

- The first three days of the week, the team was on a team training in France given by Edsko on
  performance and optimizations of Haskell code. We've been looking into data-structures, 
  streaming and piping libraries, as well as profiling and a deep analysis of how lazyness
  works under the hood. We've closed the session by profiling the current wallet, connecting
  to Jörmungandr current TestNet and analyzing cost centers and heap profile. The good news is
  that nothing important caught our attention or Edsko's. Although we've identified a few 
  minor areas that could be optimized, the wallet is performing very well with a low heap
  usage (<7MB during restoration of a non-trivial wallet) as well small cost centers. This
  is very encouraging!

- The chain follower for Jörmungandr is now completed and fully tested. Millions of 
  quickcheck scenarios were tested in situations probably much more difficult than
  what the wallet would be exposed to. In the end, we've reached a strong confidence
  that the chain following would be able to deal fine with race conditions and concurrency
  issues caused by the stateless nature of Jörmungandr REST API.

- Extended our database benchmark suites to analyze the size of typical databases produced 
  as a result of various insert calls. Doing so, we've actually discovered a bug in our
  benchmark suite which would actually degrade exponentially the performances of the call
  inserting transaction. This explained the slowness that other benchmarks were experiencing.
  The good news is that the database is very compact (up to 2.5GB for 100k transactions in 
  the worst case scenario) and runs **fast**.

- Finalize designing and implementing skeleton for the server handlers of the for Byron
  wallet API supports. We have now also generalized the server so that it could run using 
  wallets of any kind, at the same time. A first endpoint is being implemented.

- Simplified our `BlockHeader` representation so that we could in turn, highly simply the 
  chain following code also allowing to start restoring from a list of past intersection 
  points, giving more robustness to the system.

- A new database interface, independant from the wallets, has been created in order to 
  persist information regarding stake pools. Since this component is well-separated from 
  the rest of the logic, we've decided to have it completely distinct from the wallet 
  activities. This would allow, in a later stage, to spin-up a wallet server which would
  only report about stake pools activity. The end goal being to allow maximum components
  re-use between the wallet and the explorer (as well as a mandatory separation of concerns
  here).

## :construction: Underway

- Upgrade to Jörmungandr 0.5.6

- Connecting the stake pool chain follower to the stake distribution retriever. This will
  finalized the story on listing stake pools.

- Better restoration progress calculation. We noticed that Jörmungandr uses a start date quite
  far in the past. Our previous restoration progress algorithm was computing a percentage based
  on the slot numbers; yet, this was causing the restoration to immediately jump from 0% to 94%
  because the genesis block is very much in the past. We know use block height and a smarter 
  estimation of the remaining chain length to provide better reporting. Under testing.

- Implementing and e2e test remaining Byron wallet endpoints.

- More testing on the side of the stake pool database. We have already very strong test
  methods in place for the old database layer (both are using SQLite), so this is going
  extremely fast as we can simply adapt most of the existing test code to the new database
  layer!


# User Stories

### :heavy_check_mark: Support Rollbacks

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
[=============================================================================]  100% (40/40)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/25">More Information</a>
</p>

### :hammer: Listing Registered Stake Pools

> Clients interested in delegating need to know from a trusted source what are
> the available stake pools. Ideally, clients want the ability to sort existing
> stake pools according to a particular metric. 

```
[================================================================>-------------]  81% (17/21)
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
[==========================>---------------------------------------------------]  35%
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/29">More Information</a>
</p>


# Known Issues / Debts

- :warning: We still can't run the wallet (or any of the tests) on **Windows** nor
  **OSX**. The cross-compilation builds need to be fixed or, we need to consider 
  building from Windows and OSX machines. This is becoming URGENT.
