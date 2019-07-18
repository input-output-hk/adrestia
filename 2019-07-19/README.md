# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 29</strong>: 2019/07/15 →  2019/07/19
</p>

# Metrics

| Name            | Value                                        | Description                                                    |
| ---             | ---                                          | ---                                                            |
| Rolling Average | 24.5 days (-3% :chart_with_downwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 18.78 (-3% :chart_with_downwards_trend:)     | Average number of points the team can handle each week         |

# Non-Technical Summary

Continuing to polish and clear some of the technical debts we've accumulated
over the past few weeks. We are making small improvements to our internals
that aren't necessarily visible on the outside but makes for a better and more
maintainable code overall. Meanwhile, we are wrapping up the work on the API
and are implementing some of remaining endpoints that we intend to release
soon. This release will also include the ability to play with the wallet 
backend on top of a Jörmungandr BFT self-node!

# Overview 

## :heavy_check_mark: Completed

- Introduced type machinery and functions to parse and serialize ISO-8601 
  UTC time in extended and basic format. This is a necessary piece in the
  'transaction history' story, in order to allow users to filter and sort
  transactions by date of insertion.

- Finalized testing regarding fee estimation, now fetching transaction max 
  size from the network instead of hard-coded configuration value. 

- Fetched blockchain starting time and epoch length from the network's 
  genesis block instead of using hard-coded configuration values. This is
  only a first step as we'll need to keep track of the evolution of these
  parameters (which are subject to protocol updates). 

- Better error handling when connecting a wallet to a wrong network. We do
  represent target network at the type-level, and derive some implementation
  details from it (like the address format or, the network protocol and
  endpoints to use). The wallet used to fail in a non very friendly way when
  trying to connect to a wrong network (for instance, testnet instead of
  mainnet). We now handle this properly and display a more informative error
  to the user.

- Refactored some SQLite schemas regarding representation of sequential states.
  This allows for reducing drastically the number of requests (by 94%, 4
  requests instead of 60) needed to store and retrieve the wallet sequential
  state. We probably have similar "optimizations" to do in other part of the 
  database as the numerous requests were due to built-in helpers from our
  SQLite driver (`persistent`) organizing requests in a rather 'naive' way.

- Refactored and reviewed location of some pieces of code related to 'Text' 
  manipulation. This makes it easy to re-use and test some common helper code 
  that happened to be duplicated between modules. 

- Added some negative paths test scenarios to explore behaviors in the case of
  failures, especially regarding networking.

- Attempts to fix our CI environment weren't rewarded with much success. We've
  therefore disabled some flaky tests on some builds (but preserved them on
  other builds where they seemed to cause less problems). It is still unclear
  to us what is the source of the issue which seems impossible to reproduce on
  a local environment.

- Better internal structure for our state directory (storing wallet and node
  configurations and data). This allows for switching between networks and
  wallet backend easily without risking to corrupt database by accident.

## :construction: Underway

- Next release coming soon with support for Jörmungandr, transaction history,
  fee estimation and UTxO statistics.

- Port, review and adapt UTxO statistics endpoint & sister CLI command from legacy
  wallet.

- Switching from an epoch number and slot id to a 'flattened' representation
  of all slots since genesis. 

- Implement transaction list endpoint

- Implement transaction list command

- Allow converting a given slot number to a corresponding UTCTime (which demands
  keeping track of epoch length and slot length as the chain advances).

# User Stories 

### :heavy_check_mark: Review Coin Selection
### :heavy_check_mark: Bugs & Debts - Sprint 25-26

### :hammer: Finalize Transaction Endpoints

:timer_clock: Estimated end date: Jul 19

> The current / new API exposed by the wallet backend isn't yet fully implemented. 
> As Daedalus is now starting to integrate with this new API, we ought to complete
> the remaining endpoints with a lower priority that were left out the initial releases.

```
[=========================================>.....................................] 53% (10/19)
```

### :hammer: Primitives for random derivation (legacy) support

:timer_clock: Estimated end date: Aug 2

> Current wallets implementations in the wild use a different derivation scheme
> than the one we initially embedded in the new wallet backend. Yet, the new wallet
> will eventually need to support all or a subset of the features currently supported
> by the wallets in use. In a first towards supporting these features, we need to
> build the cryptographic and low-level primitives which will allow us to perform
> key management, key derivation and address discover following rules stated by the
> legacy scheme.

```
[...............................................................................] 0% (0/36)
```

# Known Issues / Debts

- While working on implementing remaining endpoints for transactions, we ran into an unforeseen
  issue regarding input resolution of transactions (finding which address corresponds to a 
  particular inputs when inputs are referencing a previous transaction and an output index). 
  This small resolution requires quite dramatic efforts and will demand the creation and 
  maintenance of a transaction index on the wallet's side. This index will contain all transactions
  made on the network and work like a lookup table for the wallet. 
  This seems to be a necessary "evil" as this piece of information can't simply be retrieved from 
  the node and has to be tracked by the wallet. Yet, it opens the room for new interesting features
  and will make migration of wallets after a hard fork easier.
