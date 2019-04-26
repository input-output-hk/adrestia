# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 17</strong>: 2019/04/22 →  2019/04/26
</p>

# Non-Technical Summary

> _NOTE_
>
> 1/3 of the team is missing and is attending the Praxis training in Miami

Getting close to having a full transaction builder, signer and submitter API.
All of internal primitives have been finalized and tested (coin selection, fee
calculation, key management, witness creation, transaction serializer etc...).
Remains some integration and comparison tests ongoing that would be finalized
next week.  Meanwhile, the API is getting more and more complete and now fully
supports basic wallets management and, transaction creation & submission. 

# Overview 

- Extended nightly benchmarks with a special address scheme that recognize a 
  propertion of the blockchain's addresses as 'ours' (for instance 10% or 50%).
  This gives us the ability to easily benchmark big / huge wallets based on real 
  data, handling UTxO of a consequent size (> 10K entries). 

- Finalize first draft of the transaction builder / signer with a few fixes on the 
  CBOR encoding. Started to work on golden tests to compare signatures produced 
  with the old implementation and hunt down any remaining bugs.

- Add primitives to encrypt & verify a passphrase so that the encryption passphrase
  for the mnemonic can be stored on disk and checked later for a better UX and error
  reporting.

- Finalize keystore interface and implementation.

- Generate change addresses for sequential scheme, following roughly the same approach
  as the external chain (and Yoroi) so that change addresses are generated in sequence
  but not more than a certain gap.

- Implement remaining API handlers deemed 'in scope':
    - (already done) create / restore wallet
    - get wallet
    - list wallet
    - delete wallet
    - create transaction

- Continued integration tests against the Servant API with more test scenarios. Started
  to port old scenarios onto the new implementation.

- Re-implement fee calculation, accounting for both random and sequential address schemes.

# User Stories 

### :heavy_check_mark: Restore Historical Data

### :heavy_check_mark: Benchmarking (restoration)

### :heavy_check_mark: Transaction Fee Estimation / Calculation

### :hammer: Initial Wallet Backend Server & Corresponding CLI

> CLI to interact with the wallet layer from the terminal. The CLI acts as a
> proxy to the wallet backend server (and therefore, requires the wallet server
> to be up-and-running) such that every endpoint from the API has an equivalent
> command in the CLI (which delegates the logic to the API via an HTTP call).
> 
> Each command should output a corresponding JSON object (got from the API).
> 
> We aim at a corresponding web-server that serves the various API endpoints,
> defaulting to an error `501 Not Implemented` for endpoints that aren't yet
> implemented.
> 
> In scope:
>
> - [Wallets List | `GET /wallets`](https://rebilly.github.io/ReDoc/?url=https://raw.githubusercontent.com/input-output-hk/cardano-wallet/master/specifications/api/swagger.yaml#operation/listWallets)
> - [Wallets Create/Restore | `POST /wallets`](https://rebilly.github.io/ReDoc/?url=https://raw.githubusercontent.com/input-output-hk/cardano-wallet/master/specifications/api/swagger.yaml#operation/postWallet)
> - [Wallets Get | `GET /wallets/{walletId}`](https://rebilly.github.io/ReDoc/?url=https://raw.githubusercontent.com/input-output-hk/cardano-wallet/master/specifications/api/swagger.yaml#operation/getWallet)
> - [Transactions Create | `POST /wallets/{walletId}/transactions`](https://rebilly.github.io/ReDoc/?url=https://raw.githubusercontent.com/input-output-hk/cardano-wallet/master/specifications/api/swagger.yaml#operation/postTransaction)

```
[============================================================================>..] 94% (16/17)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/milestones#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4163346">More Information</a>
</p>

### :hammer: Transaction creation, submission & Coin Selection

> Allow transaction creation, signing and submission (via `cardano-http-bridge`) 
> 
> Keep track of pending & known transactions in the wallet model, alongside a few metadata limited to:
> -  A unique identifier
> -  A depth (a.k.a "number of confirmations")
> -  A status: pending vs in-ledger vs invalidated (instead of: "applying", "inNewestBlocks", "persisted", "wontApply", "creating")
> -  A total amount
> -  A direction (outgoing vs incoming)
> -  A timestamp
> -  Absolute (from genesis) slot number & block number the transaction was inserted
>
> Perform (random with fallback on largest first) coin selection to balance transaction's inputs


```
[=========================================================================>.....] 93% (41/44)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/issues/144#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4157233">More Information</a>
</p>

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

# Known Issues / Debts

- Over the past few weeks, the team has side-tracked a bit with a few topics
  that were planned later on the roadmap:
  - Fee calculation
  - Time & Memory usage benchmarks
  - Wallet restoration
  
- The Miami summit followed by the Praxis training kinda dragged the
  productivity down for a while. 

- All-in-all, it took quite a significant amount of time to complete the whole
  transaction story because; though we're now approaching the end and focusing
  mostly on testing the hell our of the implementation before another
  (pre-)release; however, we delivered on other topics with great success.
