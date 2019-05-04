# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 18</strong>: 2019/04/29 →  2019/05/03
</p>

# Non-Technical Summary

> _NOTE_
>
> - Rodney & Jonathan were off this week
> - Pawel, Johannes and Piotr were off from Wednesday to Friday (National Holidays)
> - Matthias & Ante were off on Wednesday (National Holiday)

> Overall, the team was at 1/3 of its capacity this week.

With most of the team absent this week, it was a good opportunity to perform
some deep repository restructuring and re-organization of the source code in
order to prepare for the upcoming integration with Jörmungandr :snake: (the
Rust node). After finalizing various bits of testing related to the new
transaction builder, we've achieved to completely decouple the wallet core code
from any protocol-specific elements (like network serialization formats, or
address representation). In other words, the core code of the wallet backend
can work in practice with any UTxO-based crypto-currency, regardless of how the
protocol works internally. This is especially powerful for us in order to start
integrating with both the Shelley Haskell and Rust nodes coping with their
possible discrepency while still, preserving our old backend as a viable option
during the transition (and for comparison!).

# Overview 

- Made the wallet business logic "protocol-agnostic", which goes by:
  - Parameterizing the wallet layer over the address format 
  - Parameterizing the wallet layer over the binary format (in particular, the txid computation)
  - Defining a transaction-builder interface to compute witnesses and estimate tx's size

- Review the folder and file organization to prepare the Rust integration. We've
  splitted the wallet logic in two packages:
  - cardano-wallet-core: which contains the wallet business logic, primitive types
    and functions, and various interfaces (network, db, wallet layer, transaction builder ... )

  - cardano-wallet-http-bridge: which contains the bits that are specific to Byron 
    and the http-bridge. This includes how to serialize and deserialize types, how to build
    transactions and how addresses are represented. 

  This seemingly enable us to create new `cardano-wallet-*` targets which will piggy-back
  on the `cardano-wallet-core` to perform any wallet operation. The actual backend target
  is picked within the `cardano-wallet` cli **at compile-time**. This means that, in the 
  short/long run, we will end up producing multiple binaries `cardano-wallet` connected 
  behind the scene to different (possibly non-compatible) backends.
  
- Finalized CLI with commands in scope, correctly proxying to an available wallet server 
  with correct handling of user inputs. 

- Finalized change addresses generation by defining and checking a few properties
  which illustrate how the change generation should behave.

- Add golden tests for transaction signing, comparing new transaction signer and
  builder with cardano-sl implementation. Spoiler: they match.

- Figured out a way to deal with the address discrimination in a non-invasive way. 
  We've opted for an ENV var set at runtime with a clear error message when missing
  or incorrect. This allows to remove a lot of the underlying complexity of managing 
  various protocol and network magic. 

- Extended integration tests scenario for wallet creation, deletion and update via the API.

- Improved test coverage on edge-cases for coin selection and fee calculation. 

- Improved error messages on various API parsing errors.

- Various small improvements in the integration test suite to make our life easier during
  development (better error messages, redirected node and bridge output to files to keep
  stdout clean...)

# User Stories 

### :heavy_check_mark: Initial Wallet Backend Server & Corresponding CLI

### :heavy_check_mark: Transaction creation, submission & Coin Selection (Byron via cardano-http-bridge)

### :hammer: Integrate node.js IPC listener in the launcher

> See [#144](https://github.com/input-output-hk/cardano-wallet/issues/144)

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4196951">More Information</a>
</p>

```
[...............................................................................] 0% (0/5)
```

### :hammer: SQLite implementation for the DB Layer

> We do have an abstract db layer which is used by various pieces of the wallet
> backend. It is currently implemented through mutable shared variables (MVar)
> which lives in-memory and don't get persisted. Working towards a
> minimal-viable-solution, we need data to actually get serialized, persisted
> and deserialized such that they can survive a restart. We are going for a
> simple SQLite implementation in this first iteration which will likely be
> sufficient for quite a long time in the future as well, even for big players
> like exchanges.

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4196956">More Information</a>
</p>

```
[...............................................................................] 0% (0/24)
```

### :hammer: Begin integration with Jörmungandr

> To be discussed in the next iteration planning on May 6th.

```
[...............................................................................] 0% (0/??)
```


# Known Issues / Debts

- The Miami summit followed by the Praxis training kinda dragged the productivity down 
  for a while. 

- Partly because of the summit, partly because of holidays, the team hasn't
  caught up in a while. We need to have a good retrospective meeting before 
  we start working on the Rust integration.
