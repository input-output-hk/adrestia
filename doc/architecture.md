Architecture
============

## High-Level Diagram

![High-Level Diagram](high-level-diagram.svg)

## Components

### [cardano-node][cardano-node]

The core [cardano-node][cardano-node], which will support Ouroboros Praos.

**Supported environments**
-   Linux (64-bit)
-   MacOS (64-bit)
-   Windows (64-bit)
-   Docker

### [cardano-db-sync](https://github.com/input-output-hk/cardano-db-sync)

A necessary middleware to power both [cardano-rest][cardano-rest] and [cardano-graphql][cardano-graphql]. This middleware stores blockchain data fetched from [cardano-node][cardano-node] in an intermediate database to enable higher-level interfaces for blockchain exploration.

**Supported environments**
-   Linux (64-bit)
-   MacOS (64-bit)
-   Docker

### [cardano-wallet](https://github.com/input-output-hk/cardano-wallet)

This is a HTTP REST API recommended for third-party wallets and small exchanges that do not want to manage UTxOs for transactions themselves. Use this API to send and receive payments from hierarchical deterministic wallets on the Cardano blockchain via HTTP REST or a command-line interface.

**Supported environments**
-   Linux (64-bit)
-   MacOS (64-bit)
-   Windows (64-bit)
-   Docker

### [cardano-rest](https://github.com/input-output-hk/cardano-rest)

cardano-rest is made of two HTTP APIs used to retrieve transactions, addresses, and time periods (epochs and slots) from the [cardano-db-sync](https://github.com/input-output-hk/cardano-db-sync) component and submit an already serialized transaction to the network using [cardano-explorer-api](https://github.com/input-output-hk/cardano-rest) & [cardano-submit-api](https://github.com/input-output-hk/cardano-rest) respectively. The [cardano-submit-api](https://github.com/input-output-hk/cardano-rest) uses the same API as the [cardano-sl:explorer](https://cardanodocs.com/technical/explorer/api/), to ease migration from already integrated clients. New integration should however look into [cardano-graphql](https://github.com/input-output-hk/cardano-graphql).

**Supported environments**
-   Linux (64-bit)
-   MacOS (64-bit)
-   Docker

### [cardano-graphql](https://github.com/input-output-hk/cardano-graphql)

HTTP GraphQL API for Cardano. This is a more flexible alternative for blockchain exploration than [cardano-rest](https://github.com/input-output-hk/cardano-rest).

**Supported environments**
-   Linux (64-bit)
-   MacOS (64-bit)
-   Docker

## Choosing the right component

![Choosing the right component](choosing-the-right-component.png)

## Notes

See also [input-output-hk/adrestia][adrestia].
