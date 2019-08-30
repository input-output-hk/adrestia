# Wallet Backend Weekly Report

<p align="right">
  <strong>Week 35</strong>: 2019/08/26 →  2019/08/30
</p>

# Metrics

| Name            | Value                                         | Description                                                    |
| ---             | ---                                           | ---                                                            |
| Rolling Average | 17.3 days (-40% :chart_with_downwards_trend:) | Average time for a ticket to go from `In Progress` to `Closed` |
| Velocity        | 16.14 (+0%)                                   | Average number of points the team can handle each week         |

# Non-Technical Summary

This week we continued with initial work on support for rollback. Progress has
been made with tracking block height in wallet checkpoints, as well as some
preliminary refactoring work. Work in this area will continue next week.

We also added a new API endpoint that allows the user to submit an externally-
signed transaction. The use case here is that some client applications prefer
to perform key management and signing themselves. In such cases Cardano Wallet
can be used as an intermediary to send already-signed transactions to the node.
We're currently in the process of adding a corresponding CLI command
("transaction submit").

# Overview

## :heavy_check_mark: Completed

- Added tracking of block height in wallet checkpoints (rollback support).
- Added API support for submitting already-signed transactions to the node.
- Added multi-output transactions to genesis.yaml for integration testing.
- Added support for Jörmungandr 0.3.3 in continuous integration setup.
- Added supplementary property-based tests for slot arithmetic (left over from
  the work to add filtering by date to `listTransactions`).

## :construction: Underway

- Add CLI command for submitting already-signed transactions to the node.
- Save checkpoints in SQLite `DBLayer` (rollback support).
- Prepare SQLite `DBLayer` for rollback.
- Unify DBLayer QSM model and DB.MVar (rollback support).
- Change `applyBlocks` to return a list of checkpoints (rollback support).

# User Stories

### :hammer: Support Rollbacks

https://github.com/input-output-hk/cardano-wallet/milestone/25

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
[-------------------------------------------------------------------------]   0%
```

### :hammer: Signed transaction submission

https://github.com/input-output-hk/cardano-wallet/milestone/26

> Some client applications prefer to perform key management and signing
> themselves. To support such use cases, Cardano Wallet will provide an API
> endpoint and corresponding CLI command to allow clients to submit
> already-signed transactions to the node.

```
[========================>------------------------------------------------]  33%
```

### :hammer: Primitives for random derivation (legacy) support

https://github.com/input-output-hk/cardano-wallet/milestone/20

> Current wallet implementations in the wild use a different derivation scheme
> to the one we initially supported in the new wallet backend. Yet, the new
> wallet will eventually need to support all or a subset of the features
> currently supported by the wallets in use. In a first step towards supporting
> these features, we are building the cryptographic and low-level primitives
> which will allow us to perform key management, key derivation and address
> discover following rules stated by the legacy scheme.

```
[=========================================================================] 100%
```

# Known Issues / Debts

- N/A
