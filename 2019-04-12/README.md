# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 15</strong>: 2019/04/01 →  2019/04/05
</p>

# Non-Technical Summary

Continuing the effort to re-implement the transaction creation, signing and
submission as three separate steps and getting to the end of it. The team made
progresses towards a more stable implementation by reviewing and adjusting the
initial drafts we made last week. While some are focusing on the primitives 
for signing, others have implemented necessary API definitions and extended the 
wallet model to discover transactions as we absorb blocks. We've worked on 
additional tests for the wallet model to account for the transaction history.

Meanwhile, we've also made significant progress regarding coin selection and
fee adjustment and finalized porting those modules from the old code base after
another round of review and additional testing. 

As the next release approach, we are benchmarking restoration of wallets on
mainnet and testnet to get a baseline for the forthcoming release and the
subsequent ones. As we'll add feature to the wallet model, we want to ensure
the wallet backend can thrive. 

> _NOTE_
>
> This week was quite disrupted by the imminent IOHK summit and departures to Miami.

# Overview 

- Extended API definition to support transaction creation and listing (actual
  handlers yet to come).

- Extended testing suite of the wallet model to test tracking of known transactions
  (either incoming or outgoing transactions).

- Finalize restoration code and chain syncer, with progress reporting.

- Added automated nightly (in buildkite) recovery benchmark (in time and memory
  usage, for the sequential derivation scheme) against testnet and mainnet. So
  far, results are good:

    |                              | Testnet  | Mainnet  |
    | ---                          | ---      | ---      |
    | First unstable epoch         | 39       | 113      |
    | Time to first unstable epoch | ~10s     | ~ 35s    |
    | Total time                   | ~18s     | ~ 45s    |
    | Memory Usage                 | < 100 Mb | < 100 Mb |

  Machine: _i7-7700HQ 2.8GHz, 32Gb DDR4 2.4MHz, SSD PCIe Read 3500 Mb/s - Write 2700 Mb/s_
  
  We've also started working on more intense benchmarks with "special schemes"
  such that one which will "recognize" half of the address on the blockchain and
  really stress out the wallet implementation when dealing with BIG wallets (like
  exchanges).

- Extend database interface to support manipulation of wallet metadata. Also reviewed
  database tests / properties to be more consistent and readable overall.

- More negative and roundtrip tests for CLI & API types.

- Review networking layer interface, removing unneeded abstractions and making errors
  more granular.

- Port coin selection adjustment for fee from the legacy code, with extra testing and
  verifications.

- Re-implement a transaction signer / builder, still abstracted over the address scheme
  to allow easily creating transactions from any scheme.

- First API integration test scenarios (wallet creation/restoration).

# User Stories 

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
[================================================================>..............] 66% (14/17)
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
[====================================================>..........................] 67% (26/39)
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
