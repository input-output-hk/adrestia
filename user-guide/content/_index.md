---
weight: 1
title: Overview
---

# Adrestia

Adrestia is a collection of products which makes it easier to integrate with Cardano. It comes in different flavours: SDK or high-level APIs. Depending on the use-cases you have and the control that you seek, you may use any of the components below.

# Overview

As reflected on the [roadmap][roadmap], the Cardano platform is going through the following themes of development:

<p style="text-align: center">
BYRON | SHELLEY | GOGUEN | BASHO | VOLTAIRE 
</p>

Themes are being developed in parallel. So far only _Byron_ , which provides the foundation for the platform, has made it into the mainnet. The primary purpose of Byron was to release an energy-efficient, cost-effective, provably secure proof of stake consensus protocol known as [Ouroboros][ouroboros]. _Shelley_ is the next theme to be released; it'll bring decentralization and delegation of assets into _Byron_.

{{< hint info >}}
An implementation of the protocol, realized through [cardano-node][cardano-node], can be found [here][ouroboros-network]. It is deployed as core and relay nodes to form the Cardano network.

[ouroboros-network]: https://github.com/input-output-hk/ouroboros-network
[cardano-node]: https://github.com/input-output-hk/cardano-node
{{< /hint >}}

On top of this, Adrestia provides a set of services to interact with the Cardano blockchain:

- [cardano-wallet][cardano-wallet]: HTTP ReST API for managing UTxOs, and much more.
- [cardano-submit-api][cardano-rest]: HTTP API for submitting signed transactions.
- [cardano-graphql][cardano-graphql]: HTTP GraphQL API for exploring the blockchain.

It also provides an SDK, split into several low-level libraries on various topics:

- [cardano-addresses][cardano-addresses]: Address generation, derivation &  mnemonic manipulation.
- [cardano-coin-selection][cardano-coin-selection]: Algorithms for coin selection and fee balancing.
- [cardano-transactions][cardano-transactions]: Utilities for constructing and signing transactions.
- [bech32][bech32]: Haskell implementation of the Bech32 address format (BIP 0173). 

The only currently available language target is _Haskell_, although support for _JavaScript_ is being worked on and should be available soon. 

{{< hint danger >}}
**IMPORTANT NOTE**

The Byron reboot era **will end by early summer** when the Shelley hard fork occurs. This **will break ALL existing** exchange integrations. Cardano-sl will no longer be maintained or supported. **Adrestia** tooling **will support** all integrations **moving forward for Shelley**.
{{< /hint >}}

In the diagram below, components in red are non-Shelley compliant and will _not_ be available after the hard fork. The components in green are Shelley-compliant and _will_ be supported during _and_ after the hard-fork.

<table style="text-align: center; color: #ffffff;">
  <tr>
    <td colspan=2 style="background: #e74c3c;">cardano-sl:node</td>
    <td colspan=3 style="background: #2ecc71;">cardano-node</td>
  </tr>
  <tr>
    <td rowspan=2 style="background: #e74c3c;">cardano-sl:explorer</td>
    <td rowspan=2 style="background: #e74c3c;">cardano-sl:wallet</td>
    <td colspan=2 style="background: #2ecc71;">cardano-db-sync</td>
    <td rowspan=2 style="background: #2ecc71;">cardano-wallet</td>
  </tr>
  <tr>
    <td style="background: #2ecc71;">cardano-rest</td>
    <td style="background: #2ecc71;">cardano-graphql</td>
  </tr>
</table>

---

[roadmap]: https://cardanoroadmap.com/en/
[ouroboros]: https://iohk.io/en/research/library/papers/ouroboros-praosan-adaptively-securesemi-synchronous-proof-of-stake-protocol/

[cardano-wallet]: https://github.com/input-output-hk/cardano-wallet
[cardano-rest]: https://github.com/input-output-hk/cardano-rest
[cardano-graphql]: https://github.com/input-output-hk/cardano-graphql
[cardano-coin-selection]: https://github.com/input-output-hk/cardano-coin-selection
[cardano-addresses]: https://github.com/input-output-hk/cardano-addresses
[cardano-transactions]: https://github.com/input-output-hk/cardano-transactions
[bech32]: https://github.com/input-output-hk/bech32
