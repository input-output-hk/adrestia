# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 34</strong>: 2019/08/19 →  2019/08/23
</p>

# Metrics

| Name            | Value                                        | Description                                                    |
| ---             | ---                                          | ---                                                            |
| Rolling Average | 29 days (+225% :chart_with_upwards_trend:)   | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 16.14 (+0%)                                  | Average number of points the team can handle each week         |

# Non-Technical Summary

This week we wrapped up support for listing, sorting and filtering transactions
by date range, through the API and CLI.

We also started preliminary work on support for rollbacks. This support will be
crucial for a complete wallet implementation: in the face of rollbacks we must
be able to correctly keep track of which transactions are still final and which
transactions have become pending again, together with all the other state that
may have changed.

So far, the team has produced an initial design and an implementation plan.

As we make progress with the implementation, we intend to make use of QuickCheck
State Machine to ensure that the wallet keeps its model and database consistent
with the current state of the blockchain.

# Overview

## :heavy_check_mark: Completed

- Finalized work on time range filtering for the `listTransactions` endpoint.
  Much of this work was adding property tests for our slot and range arithmetic
  to improve confidence and eliminate subtle bugs. We also added an extensive
  suite of integration tests to check that filtering works across the API and
  CLI.

- Made more improvements to our CI process to overcome long build times, by
  separating out long-running integration tests into separate jobs.

- Implemented `GenChange` for the random address scheme, with an extensive set
  of accompanying property tests.

- Added golden tests for the Jörmungandr block format.

- Made fixes to our account address decoding code.

## :construction: Underway

- Add API endpoint and CLI command for submitting externally-signed transactions
- Implement `KnownAddresses` and `PersistState` for random scheme.

# User Stories

### :hammer: Support Rollbacks

https://github.com/input-output-hk/cardano-wallet/milestone/25
https://github.com/input-output-hk/cardano-wallet/wiki/Roadmap#gift-support-roll-backs

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
[Newly created]
```

### :hammer: Primitives for random derivation (legacy) support

> Current wallet implementations in the wild use a different derivation scheme
> to the one we initially supported in the new wallet backend. Yet, the new
> wallet will eventually need to support all or a subset of the features
> currently supported by the wallets in use. In a first step towards supporting
> these features, we are building the cryptographic and low-level primitives
> which will allow us to perform key management, key derivation and address
> discover following rules stated by the legacy scheme.

```
[======================================================>........................] 77%
```

# Known Issues / Debts

- N/A
