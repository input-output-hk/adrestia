========
Overview
========

As reflected on the [roadmap][roadmap], the Cardano platform is going through the following themes of development:

<p style="text-align: center">
BYRON | SHELLEY | GOGUEN | BASHO | VOLTAIRE 
</p>

Themes are being developed in parallel. So far only _Byron_ , which provides the foundation for the platform has made it into the mainnet. The primary purpose of Byron was to release a provably secure proof of stake consensus protocol that is energy efficient and cost effective known as [Ouroboros][ouroboros]. _Shelley_ is the next theme to be released soon; it'll bring decentralization and delegations of assets into _Byron_.

> **HINT**:  An implementation of the protocol is [here][ouroboros-network] and is realized through [cardano-node][cardano-node], deployed as core and relay nodes to form the Cardano network.

[ouroboros-network]: https://github.com/input-output-hk/ouroboros-network
[cardano-node]: https://github.com/input-output-hk/cardano-node

On top of this, Adrestia provides a set of services to interact with the Cardano blockchain:

- [cardano-wallet][cardano-wallet]: HTTP ReST API for managing UTxOs, and much more.
- [cardano-submit-api][cardano-rest]: HTTP API for submitting signed transactions.
- [cardano-graphql][cardano-graphql]: HTTP GraphQL API for exploring the blockchain.

As well as an SDK split into several low-level libraries on various topics:

- [cardano-addresses][cardano-addresses]: Address generation, derivation &  mnemonic manipulation.
- [cardano-coin-selection][cardano-coin-selection]: Algorithms for coin selection and fee balancing.
- [cardano-transactions][cardano-transactions]: Utilities for constructing and signing transactions.
- [bech32][bech32]: Haskell implementation of the Bech32 address format (BIP 0173). 

The only currently available language target is _Haskell_, although support for _JavaScript_ is being worked on and should be available soon. 

> **IMPORTANT NOTE**: The Byron reboot era is **soon to end by early summer** when the Shelley hard fork shall occur. This **will break ALL existing** exchange integrations. Cardano-sl shall no longer be maintained or supported. **Adrestia** tooling **will support** all integrations **moving forward for Shelley**.

In the diagram below, components in red are non-Shelley compliant and will not be available after the hard fork, while the components in green are Shelley compliant and will be supported during and after the hard-fork.

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

[roadmap]: https://cardanoroadmap.com/en/
[ouroboros]: https://iohk.io/en/research/library/papers/ouroboros-praosan-adaptively-securesemi-synchronous-proof-of-stake-protocol/

[cardano-wallet]: https://github.com/input-output-hk/cardano-wallet
[cardano-rest]: https://github.com/input-output-hk/cardano-rest
[cardano-graphql]: https://github.com/input-output-hk/cardano-graphql
[cardano-coin-selection]: https://github.com/input-output-hk/cardano-coin-selection
[cardano-addresses]: https://github.com/input-output-hk/cardano-addresses
[cardano-transactions]: https://github.com/input-output-hk/cardano-transactions
[bech32]: https://github.com/input-output-hk/bech32
