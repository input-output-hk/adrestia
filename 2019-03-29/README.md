# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 13</strong>: 2019/03/25 →  2019/03/29
</p>

# Non-Technical Summary

This week the team has focused on two major fronts: implementing the initial
new API layer for the wallet as well as testing (in particular, integration
tests). In that direction, we are now able to serve a subset of the final API,
connecting the underlying wallet, network and database layers together to do
so.
Meanwhile, we've finalized porting & upgrading our integration test framework, 
making sure that we have all the necessary tools to perform deep testing on UTxO
tracking and transaction creation the next week(s). 

# Overview 

- Additional testing scenarios (debts from previous release) mostly covering
  negative / failing paths in various modules (mnemonic primitives, networking
  protocol, primitive types, JSON serializations...)

- Model transaction metadata type & corresponding API types

- Extend API definitions, translating more endpoints from the specifications:
  - list addresses
  - update wallet
  - update wallet passphase
  - create wallet

- Integrate foundations for a the API server, implementing some endpoints
  using available components from the wallet layer (create & get wallet), 
  defaulting to a `501 Not Implemented` for other API endpoints.

- Allow the cardano-http-bridge to run on top of a local cluster of Byron 
  nodes (using nodes from cardano-sl@3.0.1). This gives us the ability to
  perform deep integration tests for transaction submission & tracking

- More extensions to the integration tests framework to allow sending non-valid
  json, custom headers and making assertions on API response codes.


# User Stories 

### :heavy_check_mark: Wallet Layer Integration

> We have created various layers and primitives during the last past weeks, so
> it's now time to connect the pieces together and come up with a "deliverable"
> that can actually do something. For this first iteration, we are aiming for
> something simple and want a basic wallet that fetches blocks from the
> network, apply them, and outputs its current state.

```
[===============================================================================] 100% (36/36)
```

<p align="right">
  <a target="_blank" href="https://github.com/input-output-hk/cardano-wallet/pulls#workspaces/cardano-wallet-5c7916c0f178504aa753dea9/reports/burndown?milestoneId=4141219">More Information</a>
</p>

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
[============================================================>..................] 79% (11/14)
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
[...............................................................................] 100% (0/39)
```

<p align="right">
  <a target="_blank" href="">More Information</a>
</p>


# Known Issues / Debts

## Untested Areas

- Overflow on address indexes during derivation
- Overflow on address indexes during pool extension (addres discovery)
- CBOR decoding of EBB 
