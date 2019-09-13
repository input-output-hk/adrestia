# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 37</strong>: 2019/09/09 → 2019/09/13
</p>

# Non-Technical Summary

Effort was invested into migrating our continuous integration environment from
[Travis](https://travis-ci.org/) to [Buildkite](https://buildkite.com) for
Travis has proven to be insufficient to cope with the load and pace of the
project. Doing so, we've made several improvements and fixes to our integration
tests scenarios making them more reliable and quicker to execute. 

In the meantime, we've put some time into polishing some existing areas in
preparation of our latest release: [v2019-09-13](https://github.com/input-output-hk/cardano-wallet/releases/tag/v2019-09-13).
This release doesn't contain many visible changes for end-users but extends the
core Haskell libraries the wallet is built upon with essential building blocks.
In particular, it contains all the necessary primitives to build wallets
compatible with the legacy scheme currently in production.

# Overview

## :heavy_check_mark: Completed

- Transitionned integration and unit tests suites from Travis to Buildkite, 
  allowing more tests to run in parallel on better machines. Overall, with
  the introduction of bors last week and Buildkite this week, we've reduced 
  our continuous integration cycles from 2h to 20minutes without cutting on
  any tests or checks :tada:. 

- Prevented integration tests from clobbering each other; we run many 
  integration scenarios and most of them demand to open a TCP connection 
  on given port. We've reworked the way resources are allocated to integration
  tests allowing more of them to run in parallel on different ports.

- Various documentation improvements and polish (top-level documentation for
  module as well as exported functions). 

- Fixed a bug in Jörmungandr binary decoders regarding some Praos-specific 
  data-structures now that we've started moving from BFT nodes to genesis/praos.

- Released a new version `v2019-09-13` bundling together two new endpoints
  (and CLI commands):

  - Transaction history with filtering and sorting 
  - Submission of already signed transactions (e.g. signed by a hardware wallet)

- Optimized creation of checkpoints during restoration to avoid overloading 
  the database with needless checkpoints.

- Refactored the wallet core engine to make it both more modular and more
  testable.  As a next step, we'll be able to create top-level interfaces (like
  an HTTP API) which uses only a subset of the wallet features, requiring only
  what's necessary. 

## :construction: Underway

- Listing registered Stake pools through Jörmungandr.
- Keeping track of unstable block headers in Jörmungandr's network layer: this to allows
  in a second time to figure out a common intersection between a wallet and a node after
  a rollback. 

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
[==================================>--------------------------------------]  45% (18/40)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/25">More Information</a>
</p>

### :hammer: Listing Registered Stake Pools

> Clients interested in delegating need to know from a trusted source what are
> the available stake pools. Ideally, clients want the ability to sort existing
> stake pools according to a particular metric. 

```
[-------------------------------------------------------------------------]  0% (??/??) (Not yet estimated)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestone/28">More Information</a>
</p>


# Known Issues / Debts

- N/A
