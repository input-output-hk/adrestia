# Wallet Backend Weekly Report 

<p align="right">
  <strong>Week 14</strong>: 2019/04/01 →  2019/04/05
</p>

# Non-Technical Summary

The team focused this week on transactions and operations related to
transactions. We've started by extending our core model to identify and keep
track of known transactions as blocks get applied. Along the way, the wallet
backend computes a few metadata (refined from the previous implementation, but
in essence, very similar) and stores the transactions and their metadata in a
dedicated location. Works has been done to port & re-implement coin selection
from the previous implementation, ending up with an implementation closer to
the wallet specification and more heavily tested. 

Meanwhile, we've also worked on extending our command-line interface to now
include many commands reflecting the underlying wallet backend API. Under the
scene, the command-line interface will make local HTTP calls to a running
server and seemingly offer a human-friendly channel of communication with the
API. The commands and CLI specification have been implemented and now only
demand the API handlers to be implemented in order to be fully functional.

# Overview 

- Ported & reviewed 'LargestFirst' coin selection policy from cardano-wallet-legacy

- Ported & reviewed 'Random' coin selection policy from cardano-wallet-legacy
  (dropping the generic implementation in favor of a concrete, simpler implementation)

- Crafted quite many unit tests for illustrating various scenarios of coin policies

- Finalized the setup of our wallet CLI, now reflecting the actual backend API through
  dedicated commands, alongside few extras like 'generate mnemonic' (generate arbitrary
  mnemonic of various length) or 'server' (start the actual http server on a given port)
  _Still remains: implementing the various command of the CLI by proxying calls to the API._

- Integrate transaction submission via the cardano-http-bridge (requires serializing the
  transaction, with its witnesses to CBOR) 

- Digged into the transaction builder & signer from the legacy code base and extracted the
  relevant bits; Still as draft, but getting close to have transaction builder, signer and
  submitter done (as three separate steps, so that we may allow users to perform any of the 
  steps on their end).

- Add transactions discovery (and computing of corresponding metadata) during block 
  application. Compared with an existing Yoroi wallet.

- Extended DB layer to store transaction metadata alongside wallet state. Also started 
  extending the DB layer to support storing and fetching wallet metadata. Getting closer
  to a full db layer interface; ready to start an implementation of the interface with SQLite
  next week.

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
[=================================================>.............................] 65% (11/17)
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
[===================>...........................................................] 25% (8/31)
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

- We've wrongly created one big ticket of 13 points for the coin selection + fee calculation. So, despite the coin selection
  (which was already a big chunk) being done, it looks like we haven't much progress in that area.

- We overlooked some aspect of the metadata storage earlier in the week which we now pay with extra work to do on 
  some tickets that were originally evaluated as "simple".
