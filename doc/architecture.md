Architecture
============

## High-Level Diagram

![High-Level Diagram](high-level-diagram.svg)

## Components

### [cardano-node][cardano-node]

The core [cardano-node][cardano-node], which will support Ouroboros Praos.

> **HINT**:  Supported environments: Linux (64-bits), MacOS (64-bits), Windows (64-bits), Docker

### [cardano-db-sync][cardano-db-sync]

A necessary middleware to power both [cardano-rest][cardano-rest] and [cardano-graphql][cardano-graphql]. This middleware stores blockchain data fetched from [cardano-node][cardano-node] in an intermediate database to enable higher-level interfaces for blockchain exploration.

> **HINT**:  Supported environments: Linux (64-bits), MacOS (64-bits), Docker

### [cardano-wallet][cardano-wallet]

[cardano-wallet][cardano-wallet] An HTTP REST API is recommended for 3rd party wallets and small exchanges who do not want to manage UTxOs for transactions themselves. Use it to send and receive payments from hierarchical deterministic wallets on the Cardano blockchain via HTTP REST or a command-line interface.

> **HINT**:  Supported environments: Linux (64-bits), MacOS (64-bits), Windows (64-bits), Docker

### [cardano-rest][cardano-rest]

[cardano-rest][cardano-rest] is made of two HTTP APIs that are used to retrieve transactions, addresses, and time periods (epochs and slots) from the [cardano-db-sync][cardano-db-sync] component and submit an already serialized transaction to the network using [cardano-explorer-api][cardano-rest] & [cardano-submit-api][cardano-rest] respectively. The [cardano-submit-api][cardano-rest] uses the same API as the [cardano-sl:explorer][cardano-sl-explorer] to ease migration from already integrated clients. New integration should however look into [cardano-graphql][cardano-graphql].

> **HINT**:  Supported environments: Linux (64-bits), MacOS (64-bits), Docker

### [cardano-graphql][cardano-graphql] 

HTTP GraphQL API for Cardano. A more flexible alternative for blockchain exploration than [cardano-rest][cardano-rest]. 

> **HINT**:  Supported environments: Linux (64-bits), MacOS (64-bits), Docker

## Choosing the right component

![Choosing the right component](choosing-the-right-component.svg)

## Notes

See also [input-output-hk/adrestia][adrestia].

[adrestia]: https://github.com/input-output-hk/adrestia
[cardano-graphql]: https://github.com/input-output-hk/cardano-graphql
[cardano-db-sync]: https://github.com/input-output-hk/cardano-db-sync
[cardano-node]: https://github.com/input-output-hk/cardano-node
[cardano-rest]: https://github.com/input-output-hk/cardano-rest
[cardano-sl-explorer]: https://cardanodocs.com/technical/explorer/api/
[cardano-wallet]: https://github.com/input-output-hk/cardano-wallet
