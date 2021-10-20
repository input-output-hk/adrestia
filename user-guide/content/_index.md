---
weight: 1
title: Overview
---

# Adrestia

Adrestia is a collection of products which makes it easier to integrate with Cardano. It comes in different flavours: SDK or high-level APIs. Depending on the use-cases you have and the control that you seek, you may use any of the components below.

# Overview

{{< hint info >}}
An implementation of the protocol is [here][ouroboros-network] and is realized through [cardano-node][cardano-node], deployed as core and relay nodes to form the Cardano network.

[ouroboros-network]: https://github.com/input-output-hk/ouroboros-network
[cardano-node]: https://github.com/input-output-hk/cardano-node
{{< /hint >}}

On top of this, Adrestia provides a set of services to interact with the Cardano blockchain:

- [cardano-wallet][cardano-wallet]: HTTP ReST API for managing UTxOs, and much more.
- [cardano-graphql][cardano-graphql]: HTTP GraphQL API for exploring the blockchain.
- [cardano-rosetta][cardano-rosetta]: [Rosetta](https://www.rosetta-api.org/docs/1.4.4/welcome.html) implementation for Cardano.
- [cardano-submit-api][cardano-submit-api]: HTTP API for submitting signed transactions.

As well as an SDK split into several low-level libraries on various topics:

- [cardano-addresses][cardano-addresses]: Address generation, derivation &  mnemonic manipulation.
- [cardano-coin-selection][cardano-coin-selection]: Algorithms for coin selection and fee balancing.
- [cardano-transactions][cardano-transactions]: Utilities for constructing and signing transactions.
- [bech32][bech32]: Haskell implementation of the Bech32 address format (BIP 0173).


---

[ouroboros]: https://iohk.io/en/research/library/papers/ouroboros-praosan-adaptively-securesemi-synchronous-proof-of-stake-protocol/

[cardano-wallet]: https://github.com/input-output-hk/cardano-wallet
[cardano-submit-api]: https://github.com/input-output-hk/cardano-node/tree/master/cardano-submit-api
[cardano-rosetta]: https://github.com/input-output-hk/cardano-rosetta
[cardano-graphql]: https://github.com/input-output-hk/cardano-graphql
[cardano-coin-selection]: https://github.com/input-output-hk/cardano-coin-selection
[cardano-addresses]: https://github.com/input-output-hk/cardano-addresses
[cardano-transactions]: https://github.com/input-output-hk/cardano-transactions
[bech32]: https://github.com/input-output-hk/bech32
