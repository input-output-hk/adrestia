=============================================
Adrestia Documentation
=============================================

Adrestia is a collection of products which makes it easier to integrate
with Cardano. It comes in different flavours: SDK or high-level APIs.
Depending on the use-cases you have and the control that you seek, you
may use any of the components below.

Overview
========

As reflected on the [roadmap][roadmap], the Cardano platform is going
through the following themes of development:

.. class:: center

BYRON | SHELLEY | GOGUEN | BASHO | VOLTAIRE

Themes are being developed in parallel. So far only *Byron* , which
provides the foundation for the platform has made it into the mainnet.
The primary purpose of Byron was to release a provably secure proof of
stake consensus protocol that is energy efficient and cost effective
known as [Ouroboros][ouroboros]. *Shelley* is the next theme to be
released soon; it’ll bring decentralization and delegations of assets
into *Byron*.

{{< hint info >}} An implementation of the protocol is `here`_ and is
realized through `cardano-node`_, deployed as core and relay nodes to
form the Cardano network.

{{< /hint >}}

On top of this, Adrestia provides a set of services to interact with the
Cardano blockchain:

-  [cardano-wallet][cardano-wallet]: HTTP ReST API for managing UTxOs,
   and much more.
-  [cardano-submit-api][cardano-rest]: HTTP API for submitting signed
   transactions.
-  [cardano-graphql][cardano-graphql]: HTTP GraphQL API for exploring
   the blockchain.

As well as an SDK split into several low-level libraries on various
topics:

-  [cardano-addresses][cardano-addresses]: Address generation,
   derivation & mnemonic manipulation.
-  [cardano-coin-selection][cardano-coin-selection]: Algorithms for coin
   selection and fee balancing.
-  [cardano-transactions][cardano-transactions]: Utilities for
   constructing and signing transactions.
-  [bech32][bech32]: Haskell implementation of the Bech32 address format
   (BIP 0173).

The only currently available language target is *Haskell*, although
support for *JavaScript* is being worked on and should be available
soon.

{{< hint danger >}} **IMPORTANT NOTE**

The Byron reboot era is **soon to end by early summer** when the Shelley
hard fork shall occur. This **will break ALL existing** exchange
integrations. Cardano-sl shall no longer be maintained or supported.
**Adrestia** tooling **will support** all integrations **moving forward
for Shelley**. {{< /hint >}}

In the diagram below, components in red are non-Shelley compliant and
will not be available after the hard fork, while the components in green
are Shelley compliant and will be supported during and after the
hard-fork.

.. raw:: html
  
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