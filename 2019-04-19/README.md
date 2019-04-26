# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 16</strong>: 2019/04/15 →  2019/04/19
</p>

# Non-Technical Summary

Most of the team was busy in Miami for the annual summit. One member stayed
behind working on finalizing the coin selection interface as well as creating a
first draft of a new fee calculation algorithm accounting for random and
sequential address derivation.

# Overview 

- Finalized some testing and polished the coin selection implementation

- Looking into computing fee estimates for transactions (natural follow-up from the coin selection work)

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
